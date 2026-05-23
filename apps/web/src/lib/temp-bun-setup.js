import { mock, describe, it, expect, beforeEach } from "bun:test";

const vi = {
  fn: (impl) => {
    const f = (...args) => {
      f.mock.calls.push(args);
      return impl ? impl(...args) : undefined;
    };
    f.mock = { calls: [] };
    f.mockReturnValue = (v) => { impl = () => v; return f; };
    f.mockReturnValueOnce = (v) => {
        const oldImpl = impl;
        impl = (...args) => {
            impl = oldImpl;
            return v;
        };
        return f;
    };
    f.mockResolvedValue = (v) => { impl = () => Promise.resolve(v); return f; };
    f.mockRejectedValue = (v) => { impl = () => Promise.reject(v); return f; };
    f.mockImplementation = (i) => { impl = i; return f; };
    return f;
  },
  mock: () => {},
  clearAllMocks: () => {},
  spyOn: (obj, method) => {
    const original = obj[method];
    const m = vi.fn(original);
    obj[method] = m;
    m.mockRestore = () => { obj[method] = original; };
    return m;
  }
};

mock.module("vitest", () => ({
  describe,
  it,
  expect,
  beforeEach,
  vi
}));

mock.module("firebase/storage", () => ({
  ref: vi.fn((storage, path) => ({ _path: path, name: path ? path.split("/").pop() : "" })),
  uploadBytesResumable: vi.fn(),
  getDownloadURL: vi.fn(),
  deleteObject: vi.fn(),
  listAll: vi.fn(),
}));

mock.module("./firebase", () => ({
  storage: {},
}));

mock.module("./imageMetadata", () => ({
  extractImageMetadata: vi.fn(),
  createThumbnail: vi.fn(),
}));
