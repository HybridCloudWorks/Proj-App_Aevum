import { useNavigate } from "react-router-dom";
import "./AdminDelegationScreen.css";

function AdminDelegationScreen() {
  const navigate = useNavigate();

  return (
    <div className="bg-background-light dark:bg-background-dark font-display min-h-screen flex flex-col antialiased selection:bg-primary/30">
      <header className="sticky top-0 z-50 glass-panel-light dark:glass-panel border-b-0">
        <div className="flex items-center justify-between p-4 pb-3">
          <button
            className="flex size-10 shrink-0 items-center justify-center rounded-full hover:bg-black/5 dark:hover:bg-white/10 text-slate-900 dark:text-white transition-colors"
            onClick={() => navigate(-1)}
          >
            <span className="material-symbols-outlined">arrow_back</span>
          </button>
          <div className="flex-1 text-center">
            <h2 className="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-tight">
              Admin Delegation
            </h2>
            <p className="text-slate-500 dark:text-slate-400 text-xs font-medium">
              Manage tree edit permissions
            </p>
          </div>
          <button className="flex w-10 items-center justify-center text-primary font-bold text-sm hover:text-primary/80 transition-colors">
            Save
          </button>
        </div>
      </header>
      <main className="flex-1 px-4 py-6 space-y-6 overflow-y-auto pb-24">
        <div className="relative group">
          <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
            <span className="material-symbols-outlined">search</span>
          </div>
          <input
            className="block w-full rounded-xl border-none bg-white dark:bg-[#1c242e] py-3 pl-10 pr-4 text-slate-900 dark:text-white placeholder-slate-400 focus:ring-2 focus:ring-primary shadow-sm"
            placeholder="Search family members..."
            type="text"
          />
        </div>
        <div className="grid grid-cols-1 gap-4">
          <div className="glass-panel-light dark:glass-panel rounded-2xl p-5 shadow-sm relative overflow-hidden group">
            <div className="absolute top-0 right-0 p-3 opacity-10">
              <span className="material-symbols-outlined text-6xl text-primary rotate-12 transform">
                shield_person
              </span>
            </div>
            <div className="flex items-center gap-4 relative z-10">
              <div className="relative">
                <div
                  className="size-16 rounded-full bg-cover bg-center border-2 border-primary shadow-lg"
                  data-alt="Portrait of the tree owner, a middle-aged man smiling"
                  style={{
                    backgroundImage:
                      "url('https://lh3.googleusercontent.com/aida-public/AB6AXuAp6vazGbaKR_2Dz70q51ykRZANdxVxjFX_OGGEEFiwcjpOU6jP_oPfbtNreI-OVUIf1Ry_BKEKlcOywAJ2PupUelMM0JMhGtJVgbTJIBUqEDg6F-zR8H4FJN6QRY7qQDdcS9WPFuaUqXZ_DBdiclnbDq9djoaIcwzvUksxQLxLFpdfDWz7dUrSAgdQzljMzo6i3Sx-W-5_OCPhx0vYlIbkR_PNCsTpN7DQM9sCSR9RqJ8s3eOKRXmidtBl6c7LXhBpaluZ6MKIak8')",
                  }}
                ></div>
                <div className="absolute -bottom-1 -right-1 bg-primary text-white p-1 rounded-full border-2 border-white dark:border-[#101922] flex items-center justify-center">
                  <span className="material-symbols-outlined text-[14px]">
                    verified_user
                  </span>
                </div>
              </div>
              <div className="flex flex-col gap-1">
                <h3 className="text-slate-900 dark:text-white text-lg font-bold leading-none">
                  Me (Tree Owner)
                </h3>
                <p className="text-primary text-sm font-semibold">
                  Full Authority
                </p>
                <p className="text-slate-500 dark:text-slate-400 text-xs">
                  Owner of Aevum Legacy #8291
                </p>
              </div>
            </div>
          </div>
          <div className="glass-panel-light dark:glass-panel rounded-2xl p-5 shadow-sm relative overflow-hidden">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-slate-900 dark:text-white text-md font-bold flex items-center gap-2">
                <span className="material-symbols-outlined text-primary">
                  policy
                </span>
                Role Summary
              </h3>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="space-y-3">
                <div className="flex items-center gap-2">
                  <div className="p-1.5 rounded-lg bg-orange-100 dark:bg-orange-900/30 text-orange-600 dark:text-orange-400">
                    <span className="material-symbols-outlined text-sm">
                      crown
                    </span>
                  </div>
                  <span className="text-sm font-bold text-slate-800 dark:text-slate-200">
                    Tree Owner
                  </span>
                </div>
                <div className="pl-2 border-l-2 border-slate-200 dark:border-slate-700 space-y-2">
                  <div className="flex items-start gap-2">
                    <span className="material-symbols-outlined text-base text-slate-400 mt-0.5">
                      lock_open
                    </span>
                    <p className="text-xs text-slate-600 dark:text-slate-400 leading-tight">
                      Full Vault Access
                    </p>
                  </div>
                  <div className="flex items-start gap-2">
                    <span className="material-symbols-outlined text-base text-slate-400 mt-0.5">
                      family_star
                    </span>
                    <p className="text-xs text-slate-600 dark:text-slate-400 leading-tight">
                      Out-of-wedlock ID
                    </p>
                  </div>
                  <div className="flex items-start gap-2">
                    <span className="material-symbols-outlined text-base text-slate-400 mt-0.5">
                      content_cut
                    </span>
                    <p className="text-xs text-slate-600 dark:text-slate-400 leading-tight">
                      Tree Pruning
                    </p>
                  </div>
                </div>
              </div>
              <div className="h-px w-full bg-slate-200 dark:bg-slate-700 md:hidden"></div>
              <div className="space-y-3">
                <div className="flex items-center gap-2">
                  <div className="p-1.5 rounded-lg bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400">
                    <span className="material-symbols-outlined text-sm">
                      badge
                    </span>
                  </div>
                  <span className="text-sm font-bold text-slate-800 dark:text-slate-200">
                    Tree Admin
                  </span>
                </div>
                <div className="pl-2 border-l-2 border-slate-200 dark:border-slate-700 space-y-2">
                  <div className="flex items-start gap-2">
                    <span className="material-symbols-outlined text-base text-green-500 mt-0.5">
                      check_circle
                    </span>
                    <p className="text-xs text-slate-600 dark:text-slate-400 leading-tight">
                      Approve Marriage Links
                    </p>
                  </div>
                  <div className="flex items-start gap-2">
                    <span className="material-symbols-outlined text-base text-green-500 mt-0.5">
                      check_circle
                    </span>
                    <p className="text-xs text-slate-600 dark:text-slate-400 leading-tight">
                      Verify Sibling Links
                    </p>
                  </div>
                  <div className="flex items-start gap-2">
                    <span className="material-symbols-outlined text-base text-red-400 mt-0.5">
                      block
                    </span>
                    <p className="text-xs text-slate-400 dark:text-slate-500 italic leading-tight">
                      Cannot Delete Nodes
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="h-px w-full bg-slate-200 dark:bg-white/10 my-2"></div>
        <div>
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-slate-900 dark:text-white text-lg font-bold">
              Family Members
            </h3>
            <button className="text-primary text-xs font-bold uppercase tracking-wide flex items-center gap-1 hover:bg-primary/10 px-2 py-1 rounded transition-colors">
              <span className="material-symbols-outlined text-sm">add</span>{" "}
              Invite New
            </button>
          </div>
          <div className="grid grid-cols-1 gap-3">
            <div className="glass-panel-light dark:glass-panel p-4 rounded-xl flex items-center justify-between shadow-sm border-l-4 border-l-primary transition-all">
              <div className="flex items-center gap-3">
                <div className="relative">
                  <div
                    className="size-12 rounded-full bg-cover bg-center"
                    data-alt="Portrait of Sarah, a young woman smiling"
                    style={{
                      backgroundImage:
                        "url('https://lh3.googleusercontent.com/aida-public/AB6AXuBxp91_qwMtQJMIxk40NT17eUUeoMQWDBozJ5YndVtdib8edCQ-5jSpwLmPpj0d-CL4e6ByIC7qYldLpkPfNkssQ_ljS807HAJAynwnJ7OYNthfxbWalnJFzldt2uqyRjFI51roNDHEWfWQexNNHuPSnYK4WLkpryHprM3ClCYUhnNHI6DhNSX-qY41RoeJH63Ok8o99tt4Dcy2j9H5EnGmHzLQC7crzJxTXXc6SgTg-F6pQ-GDNpB3exHC9JjYgjZyToRECznZ_BE')",
                    }}
                  ></div>
                </div>
                <div>
                  <p className="text-slate-900 dark:text-white font-bold text-base">
                    Sarah Miller
                  </p>
                  <p className="text-slate-500 dark:text-slate-400 text-xs">
                    Cousin • Joined 2021
                  </p>
                  <div className="mt-1 flex gap-1">
                    <span className="bg-primary/20 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded">
                      ADMIN
                    </span>
                  </div>
                </div>
              </div>
              <div className="flex items-center gap-3">
                <label
                  className="flex items-center cursor-pointer relative"
                  htmlFor="toggle1"
                >
                  <input
                    defaultChecked
                    className="sr-only peer"
                    id="toggle1"
                    type="checkbox"
                  />
                  <div className="w-11 h-6 bg-slate-200 dark:bg-slate-700 rounded-full border border-slate-300 dark:border-slate-600 transition-colors duration-200 ease-in-out peer-checked:bg-primary peer-checked:border-primary"></div>
                  <div className="absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition-transform duration-200 ease-in-out peer-checked:translate-x-5 shadow-sm"></div>
                </label>
              </div>
            </div>
            <div className="glass-panel-light dark:glass-panel p-4 rounded-xl flex items-center justify-between shadow-sm border-l-4 border-l-transparent opacity-80 hover:opacity-100 transition-all hover:border-l-primary/50">
              <div className="flex items-center gap-3">
                <div
                  className="size-12 rounded-full bg-cover bg-center grayscale-[50%]"
                  data-alt="Portrait of Uncle Joe, an older man with glasses"
                  style={{
                    backgroundImage:
                      "url('https://lh3.googleusercontent.com/aida-public/AB6AXuD7lpk3_3FOsoZqMJ05qCBnokKPXGfOIxBhMnS8eNx1JkYc_cae90Jms8w8GylQdWlxtnp8DFjOW6QLvr99agac0HYkkvurD7GmEqd5Jsb7LnhtfbL1lN4RhxNYKsNHn7nJsNuJ8p4QdXWOuz49hDQ9hooG0h4kQRR9bCTtkLod7dIBEfNaG2UynRbJS5sWQDECVtUTuaGHLcGEyvoszMItMBcx7YdWbcUaBc5CJc3d35BDFGw7LEV6dCSg-WXitFteFZ9pEZLPCQ8')",
                  }}
                ></div>
                <div>
                  <p className="text-slate-900 dark:text-white font-bold text-base">
                    Uncle Joe
                  </p>
                  <p className="text-slate-500 dark:text-slate-400 text-xs">
                    Uncle • Joined 2020
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-3">
                <label
                  className="flex items-center cursor-pointer relative"
                  htmlFor="toggle2"
                >
                  <input
                    className="sr-only peer"
                    id="toggle2"
                    type="checkbox"
                  />
                  <div className="w-11 h-6 bg-slate-200 dark:bg-slate-700 rounded-full border border-slate-300 dark:border-slate-600 transition-colors duration-200 ease-in-out peer-checked:bg-primary peer-checked:border-primary"></div>
                  <div className="absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition-transform duration-200 ease-in-out peer-checked:translate-x-5 shadow-sm"></div>
                </label>
              </div>
            </div>
            <div className="glass-panel-light dark:glass-panel p-4 rounded-xl flex items-center justify-between shadow-sm border-l-4 border-l-primary transition-all">
              <div className="flex items-center gap-3">
                <div className="relative">
                  <div
                    className="size-12 rounded-full bg-cover bg-center"
                    data-alt="Portrait of Marcus, a young man with a beard"
                    style={{
                      backgroundImage:
                        "url('https://lh3.googleusercontent.com/aida-public/AB6AXuC3NpZnE3qsQqGUhn_jfxVhuLavlBnYcRagvjY6RGUFhEg4hppXF4kPYQ3P0yvGsNveNCn_SRHc8rFRpkF99AE-XawA_urzFduYlZgX03rVxsVbOcOFpSTlbEfZvX92DXHH0yWVRIgRAs35sRYmknxkGLBa84BMVtn9mD7rIiRQJ7FT0OlzrIGLeX11mHmMELSumGD_ALfMj4u487pAPuApU43d7WPX5aqUSLvQ_d2wjI8w32pvw1f30e0Rl47mgKbFDGs4hLWA7W8')",
                    }}
                  ></div>
                </div>
                <div>
                  <p className="text-slate-900 dark:text-white font-bold text-base">
                    Marcus Ray
                  </p>
                  <p className="text-slate-500 dark:text-slate-400 text-xs">
                    Brother • Joined 2022
                  </p>
                  <div className="mt-1 flex gap-1">
                    <span className="bg-primary/20 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded">
                      ADMIN
                    </span>
                  </div>
                </div>
              </div>
              <div className="flex items-center gap-3">
                <label
                  className="flex items-center cursor-pointer relative"
                  htmlFor="toggle3"
                >
                  <input
                    defaultChecked
                    className="sr-only peer"
                    id="toggle3"
                    type="checkbox"
                  />
                  <div className="w-11 h-6 bg-slate-200 dark:bg-slate-700 rounded-full border border-slate-300 dark:border-slate-600 transition-colors duration-200 ease-in-out peer-checked:bg-primary peer-checked:border-primary"></div>
                  <div className="absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition-transform duration-200 ease-in-out peer-checked:translate-x-5 shadow-sm"></div>
                </label>
              </div>
            </div>
            <div className="glass-panel-light dark:glass-panel p-4 rounded-xl flex items-center justify-between shadow-sm border-l-4 border-l-transparent opacity-80 hover:opacity-100 transition-all hover:border-l-primary/50">
              <div className="flex items-center gap-3">
                <div
                  className="size-12 rounded-full bg-cover bg-center grayscale-[50%]"
                  data-alt="Portrait of Emily, a woman with glasses looking professional"
                  style={{
                    backgroundImage:
                      "url('https://lh3.googleusercontent.com/aida-public/AB6AXuDXZQIcefNnmuxGyIQUcZCB4Baq8ydb6b6QgeCdIA4eX3EJWNYOY5s3pf0MxR1Ldm9H8ZdbBopyJOTyW9ng_4qEvIPyCDKBKy6XA1s9_SlNJGz6lM5U8Vg4UI1WOVlyRxkxpe6tJhnzkrSEyvxxrKYvjoVb-Ct3hs7_3jNCwQt8lX1RGeBf6KWKAFXeIxZ_3q1OeGgcb9XAEkIJKqGvWB439Ex7nIUH8o5Gr5Gk7IYEFmf2EtfGKLpwHuOe8FlyArI9BnLeF4kEp9Y')",
                  }}
                ></div>
                <div>
                  <p className="text-slate-900 dark:text-white font-bold text-base">
                    Emily Chen
                  </p>
                  <p className="text-slate-500 dark:text-slate-400 text-xs">
                    Spouse • Joined 2019
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-3">
                <label
                  className="flex items-center cursor-pointer relative"
                  htmlFor="toggle4"
                >
                  <input
                    className="sr-only peer"
                    id="toggle4"
                    type="checkbox"
                  />
                  <div className="w-11 h-6 bg-slate-200 dark:bg-slate-700 rounded-full border border-slate-300 dark:border-slate-600 transition-colors duration-200 ease-in-out peer-checked:bg-primary peer-checked:border-primary"></div>
                  <div className="absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition-transform duration-200 ease-in-out peer-checked:translate-x-5 shadow-sm"></div>
                </label>
              </div>
            </div>
          </div>
        </div>
      </main>
      <div className="fixed bottom-0 left-0 right-0 h-12 bg-gradient-to-t from-background-light dark:from-background-dark to-transparent pointer-events-none z-40"></div>
    </div>
  );
}

export default AdminDelegationScreen;
