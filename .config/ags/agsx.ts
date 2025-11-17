import Gio from "gi://Gio";
import type GObject from "gi://GObject";
import { Accessor, createBinding, createComputed } from "ags";

export type Accessible<T> = T | Accessor<T>;

export function kebabify<T extends { toString: () => string }>(
  value: T,
): string {
  return value
    .toString()
    .replace(/([a-z])([A-Z])/g, "$1-$2")
    .replaceAll("_", "-")
    .toLowerCase();
}

export function pack<T>(target: Accessible<T>): Accessor<T> {
  if (target instanceof Accessor) {
    return target;
  }

  return new Accessor(() => target);
}

export function unpack<T>(target: Accessible<T>): T {
  if (target instanceof Accessor) {
    return target.get();
  }

  return target;
}

export function bind<
  T extends GObject.Object | Gio.Settings,
  K extends keyof T,
>(target: Accessor<T>, key: K): Accessor<T[K]>;
export function bind<
  T extends GObject.Object | Gio.Settings,
  K extends keyof T,
>(
  target: Accessor<T | undefined>,
  key: K,
): Accessor<T[K] | undefined>;
export function bind<
  T extends GObject.Object | Gio.Settings,
  K extends keyof T,
>(target: Accessor<T | undefined>, key: K, fallback: T[K]): Accessor<T[K]>;
export function bind<
  T extends GObject.Object | Gio.Settings,
  K extends keyof T,
>(target: Accessible<T>, key: K, fallback?: T[K]): Accessor<T[K]>;
export function bind<
  T extends GObject.Object | Gio.Settings,
  K extends keyof T,
>(
  target: Accessor<T | undefined> | Accessible<T>,
  key: K,
  fallback?: T[K],
): Accessor<T[K] | undefined> {
  if (target instanceof Accessor) {
    if (fallback !== undefined) {
      return createSafeAccessorBinding(target, key, fallback);
    } else {
      return createAccessorBinding(target, key);
    }
  } else {
    if (fallback !== undefined) {
      return createSafeBinding(target, key, fallback);
    } else {
      // @ts-expect-error createBinding overloads are cooked
      return createBinding(target, key);
    }
  }
}

export function createSafeBinding<
  T extends GObject.Object | Gio.Settings,
  K extends keyof T,
>(gobject: T, key: K, fallback: T[K]): Accessor<T[K]> {
  // @ts-expect-error createBinding overloads are cooked
  return createBinding(gobject, key)((v) => v ?? fallback);
}

export function createAccessorBinding<
  T extends GObject.Object | Gio.Settings,
  K extends keyof T,
>(accessor: Accessor<T | undefined>, key: K): Accessor<T[K] | undefined>;
export function createAccessorBinding<
  T extends GObject.Object | Gio.Settings,
  K extends keyof T,
>(accessor: Accessor<T>, key: K): Accessor<T[K]>;
export function createAccessorBinding<
  T extends GObject.Object | Gio.Settings,
  K extends keyof T,
>(accessor: Accessor<T | undefined>, key: K): Accessor<T[K] | undefined> {
  let gobject = accessor.get();
  let id: number | undefined;

  const subscribe = (callback: () => void) => {
    if (gobject && id === undefined) {
      const signal = gobject instanceof Gio.Settings ? "changed" : "notify";
      id = gobject.connect(`${signal}::${kebabify(key.toString())}`, callback);
    }
  };

  const unsubscribe = () => {
    if (gobject && id !== undefined) {
      gobject.disconnect(id);
      id = undefined;
    }
  };

  return new Accessor<T[K]>(
    // @ts-expect-error accessor getter type is cooked
    () => gobject?.[key],
    (notify) => {
      subscribe(notify);

      const cancel = accessor.subscribe(() => {
        const g = accessor.get() || undefined;
        if (g === gobject) {
          return;
        }

        unsubscribe();
        gobject = g;
        subscribe(notify);
        notify();
      });

      return () => {
        unsubscribe();
        cancel();
      };
    },
  );
}

export function createSafeAccessorBinding<
  T extends GObject.Object | Gio.Settings,
  K extends keyof T,
>(accessor: Accessor<T | undefined>, key: K, fallback: T[K]): Accessor<T[K]> {
  return createAccessorBinding(accessor, key)((v) => v ?? fallback);
}

export { createBinding, createComputed };
