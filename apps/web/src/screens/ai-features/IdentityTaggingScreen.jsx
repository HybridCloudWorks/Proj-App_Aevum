import { useNavigate } from "react-router-dom";
import BottomNav from "@/components/BottomNav";
import "./IdentityTaggingScreen.css";

// ⚡ Bolt Optimization: Define NEXT_ITEMS outside component to prevent recreation on every render
// Optimization: Define static arrays outside component to prevent recreation on every render
const NEXT_ITEMS = [
  {
    count: 8,
    img: "https://lh3.googleusercontent.com/aida-public/AB6AXuAJVIyA0Lztk5kUR6V7pgT_JvZPVk4TzwqxwS1AOGogPtHF6pY1AhG2Ey7i3wISgu8cNL3tkXX1WN9dkOjSDv9LigYi0E5dfY4snmWpBcdVp0Q22m6u0lUdtpF8Q5V8nrQnrIQ0vZzTJHpk9kYEPxLthFBqyXsi75Cturl5n0x-1XfJPbfDmyzPiPSTVouIHBolS7iqHa-Jpb1RhT5OjnOPML9bS3-Os1M-wzkIKmM3RMITIQfyqVxZbzluKDInm2eIuD0ra_wTMFk",
  },
  {
    count: 5,
    img: "https://lh3.googleusercontent.com/aida-public/AB6AXuC2vqRsXQ7b-79adyFGPz1Qjsq8IvjvniwLDEHaUWj62MWdBOThIN55QaUm2XWtKeDZvJTGKtMYZ4jDUu5dpmFB5uAzjYuZUoi8N25SfCbmYBZitz_PuWWM5LPICUNoc3p6SBGrLomgvNftS_YQ4anW-4pyDGE6mJKcg67HJaDSf8WpIlzybGNjEHJKTKBVr5lYiXeyzIKnjF52WYdVSxUM07kJUAtXQC3fzi62SzoAKiO0DiM23oPf5jlQBsc-vWnk6WhuQpJRFs0",
  },
  {
    count: 3,
    img: "https://lh3.googleusercontent.com/aida-public/AB6AXuDgd9lbSIDtwmL3NnTiAQ5E8LYKo_ReAaSTdhHYBPX3GHhQp9duEnZVT7ymoShbDc_EmnRv5BINEA0ovAqYpNqFPXZtpKNDVYPwOv_YHpeutaABg9WJKLHJOAGZbLQF7y4g19RRW57bZBrcmf5WhkFpwSbDXf2cZHWlGqbZd7Qb2z3F6krLitpDjbKAz5tOEJPsNCFFoE9ASw2F-0mZrOHljt_nGkAhjk6P-DJNR3pUp-Lgnct048Xjkg2Fmd8Hxgc7IddfjvcnuhA",
  },
];

const CONTEXT_PHOTOS = [
  {
    tags: true,
    img: "https://lh3.googleusercontent.com/aida-public/AB6AXuBBLJPZoya-57UF9LHyeY02i2XCDXGJOKD0jOTRaSxSzqTNC8QG1tDDAGVfLgLC_53jwPV9rvqY6Mm6Lvc_RnZ9yfAY6t4UNWbKEzFP7MF1qYX9WSG_WFduv-VfybsgdRR7jGRbic8k28RmlTzFaVoqqgDPId-gwB94cEeOMhrxDzUUmBVkGwAoEgb3d0C3LyezcQB_vFH9oloho6j-PZjY0t6OClGUxiD4g8ytqIOpJKMBFPckpXtMEY17bmXXpLBbOXO1Z3zNjAs",
  },
  {
    tags: false,
    img: "https://lh3.googleusercontent.com/aida-public/AB6AXuBtkdYPQYNk7-fzN6fC_XMHe_-itwb97SPm1Myy_gaj8G40HdjtTO5iA8ndf1B5dGnc-wyRPqTlFJUkXsyBLl21KVcYddSf7fRPYRrtyCxt963togRu4cUddLrIENZveUmKxzm1LcJRl_gHPiuHBqhFS3OIS975fRBE8JhVK2qAppuvvxnkBOV6L1CyPA8Gh_rUBzlLvBtVM9NI0ta138eW669h1zz4_WhYBojrD5hfP9kaKlJ0Z4IQy1-H8f-tYwxeVCS3e0xNfSk",
  },
  {
    tags: false,
    img: "https://lh3.googleusercontent.com/aida-public/AB6AXuDz9YC_p9V1LKjhr4RUFau2dvhUc4ynu2l4Y-UCgEhcR0jZf-zCZiW7H_pbaG1gDPi3I0G3I0mLnXmj66csm0MGpavzSL9X_hvJIeD3XO8P_4iyI3anAEaWcfj0dntT0PSCqt0rIfri80DTM4hbJJeW4A0R951UlN31qEuUnjYJ3CxppaSftMFg_tw7rlaaZBPvtdtMiNhmrV3WgUkf8Kt5dL1tMQHKDYX679-8CdzU7OgXydCEHDv-iHRm0b-1kflKHGXm2MUtnuY",
  },
  {
    tags: false,
    img: "https://lh3.googleusercontent.com/aida-public/AB6AXuCzr2Jxj6bejbvHjt3_Y2wowBXJdIIa1Njk641HdCPoABdgL0E_uzo_OWgZTGw_k0BkHlUyB4ltVvfbbmvjoHJIzIqucDFq-BqjlBIbptOIjRIXKyZKSlMeHWKDYuWuW3sfGbuiGW1ru4GfpcTqtJROl3VmaReRYhuxzc7mhL0Kbw8k27nws83sdPpGcEtbXvJFt-uVuOYNubztczb8fv0NJXsnoxiR7BrjL2jcAU57IAZozFrP7AeHOScfuvy-UAlIsIqCsnVpdAY",
  },
  {
    tags: false,
    img: "https://lh3.googleusercontent.com/aida-public/AB6AXuDSUK2cxKT9JNqifqRXe0ZpXywU91xXnXV4se52gmq3IMBGZLYfQMgF7bl8SIe_J8Yz19aZaWEqxcHj6WESm_P42V8_ojvo8aKeZ1y2zi-gmhXs52PMd4v4bvakC4OJrlhfjwXMepARSdtnQuc16NGKJzKzao0ZZmS-jHeVPO9AWByOfLjwRVt_TcsaJeaR-64QnyWP_iqBex344SIn2GDPQGsBgAFYnX30PRvNkT0OZnxlTCSnRuodR8lwDQvX5v7uv0rEC1vJlKk",
  },
];

function IdentityTaggingScreen() {
  const navigate = useNavigate();

  return (
    <div className="bg-background-light dark:bg-background-dark font-display antialiased min-h-screen pb-20">
      <div className="relative flex flex-col h-full w-full bg-background-light dark:bg-background-dark overflow-x-hidden">
        {/* Header */}
        <header className="flex items-center bg-background-light dark:bg-background-dark p-4 pb-2 justify-between sticky top-0 z-20">
          <button
            className="text-gray-900 dark:text-white flex h-12 w-12 shrink-0 items-center justify-center rounded-full active:bg-gray-200 dark:active:bg-gray-800 transition-colors"
            onClick={() => navigate(-1)}
          >
            <span className="material-symbols-outlined">arrow_back</span>
          </button>
          <h2 className="text-gray-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] flex-1 text-center">
            Tag Faces
          </h2>
          <div className="flex w-12 items-center justify-end">
            <button className="text-gray-500 dark:text-[#9dabb9] hover:text-primary dark:hover:text-primary transition-colors flex items-center justify-center h-12 w-12 rounded-full active:bg-gray-200 dark:active:bg-gray-800">
              <span className="material-symbols-outlined">filter_list</span>
            </button>
          </div>
        </header>

        {/* Progress Bar */}
        <div className="px-6 py-2">
          <div className="flex justify-between text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
            <span>Identifying 3 of 15</span>
            <span>20%</span>
          </div>
          <div className="h-1.5 w-full bg-gray-200 dark:bg-gray-800 rounded-full overflow-hidden">
            <div
              className="h-full bg-primary rounded-full transition-all duration-300 ease-out"
              style={{ width: "20%" }}
            ></div>
          </div>
        </div>

        {/* Main Title Area */}
        <div className="px-6 pt-4 pb-2">
          <h2 className="text-gray-900 dark:text-white tracking-tight text-[28px] font-extrabold leading-tight text-left">
            Who is this?
          </h2>
          <p className="text-gray-600 dark:text-gray-400 text-sm font-medium leading-normal mt-1 flex items-center gap-1">
            <span className="material-symbols-outlined text-green-500 text-[18px]">
              verified_user
            </span>
            High confidence match found.
          </p>
        </div>

        {/* Carousel: Needs Identification */}
        <div className="flex w-full overflow-x-auto no-scrollbar px-6 py-4 pb-6 gap-4 snap-x snap-mandatory scroll-smooth">
          {/* Active Item (Center) */}
          <div className="snap-center shrink-0 flex flex-col items-center gap-2">
            <div className="relative group cursor-pointer transform hover:scale-105 transition-transform duration-200">
              <div
                className="w-24 h-24 bg-center bg-no-repeat bg-cover rounded-full ring-4 ring-primary shadow-lg shadow-primary/20"
                style={{
                  backgroundImage:
                    'url("https://lh3.googleusercontent.com/aida-public/AB6AXuB1AUTQfohpATpAZT5xMlpYxvpKWMTBsO9uO6gCp5Hl3b4LYzf1C5WeNKH5WeqJE9SqeJ5xRdKUf9mGEFfSNOtm89zlwFpxB5iU3Mh5Aa9YU9wZ13c4obwMVM3H1wes7MkxPdTIL9DXuVO6a1KruKbomtx1uVYw_AxxVV4SFVxZZUX4-u8Ne4zCq3O9-pbdiODdnFUCHkKFxoYnSB2ywOucXI0ApuuMqxAX9vBM0qwXI_KgzJzeRS5lfwXJmsPRxkPZc3QUfdobBrE")',
                }}
              ></div>
              <div className="absolute -bottom-1 -right-1 bg-primary text-white text-[10px] font-bold px-2 py-0.5 rounded-full border-2 border-background-light dark:border-background-dark shadow-md">
                12
              </div>
            </div>
            <p className="text-primary font-bold text-sm">Active</p>
          </div>

          {/* Next Items */}
          {NEXT_ITEMS.map((item, index) => (
            <div
              key={index}
              className="snap-center shrink-0 flex flex-col items-center gap-2 opacity-60 hover:opacity-100 transition-opacity"
            >
              <div className="relative cursor-pointer">
                <div
                  className="w-20 h-20 bg-center bg-no-repeat bg-cover rounded-full ring-2 ring-gray-200 dark:ring-gray-700 grayscale hover:grayscale-0 transition-all"
                  style={{ backgroundImage: `url("${item.img}")` }}
                ></div>
                <div className="absolute -bottom-1 -right-1 bg-gray-600 text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full border-2 border-background-light dark:border-background-dark shadow-sm">
                  {item.count}
                </div>
              </div>
              <p className="text-gray-500 dark:text-gray-400 font-medium text-xs">
                Unknown
              </p>
            </div>
          ))}
        </div>

        {/* Action Card Area */}
        <div className="px-4 mb-6">
          <div className="bg-white dark:bg-[#1E1E1E] rounded-2xl overflow-hidden shadow-lg border border-gray-100 dark:border-gray-800 transition-all hover:shadow-xl">
            {/* Hero Image & Suggestion Overlay */}
            <div className="relative h-64 w-full bg-gray-200 dark:bg-gray-800 group">
              <div
                className="absolute inset-0 bg-center bg-cover bg-no-repeat transition-transform duration-700 group-hover:scale-105"
                style={{
                  backgroundImage:
                    'url("https://lh3.googleusercontent.com/aida-public/AB6AXuBEw5vwtm1z37BmHHNm7tBKmQmVlFhmBg6PQp3ySVgaDC0o8z3vkmv8g6k77_pWCLcNpBm8V_8Je3otAtQw9CJqYJedzYkRf-qyxxO7-sWi_lr3vndKPefA_UFGmPboU1Qfdv9bUiQeQXNgrmTRQOVvR78KbP1T0fHRC3WBRoLrxp16puA1HK-dE0l_2DCn5DEY3ZBXakcNlGdhxCe49l9sKJHxRa6Ee18ASznsukktw9jhz3qw7MokkS6QN6FYQO0ztjw5uS8Aqa8")',
                }}
              ></div>
              {/* Gradient Overlay */}
              <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent flex flex-col justify-end p-5">
                <div className="flex items-start gap-3 mb-2">
                  <div className="bg-primary/20 backdrop-blur-md p-2 rounded-lg text-primary-light shadow-lg shadow-black/20">
                    <span className="material-symbols-outlined text-blue-300">
                      smart_toy
                    </span>
                  </div>
                  <div>
                    <h3 className="text-white text-xl font-bold leading-tight drop-shadow-md">
                      Is this Aunt Marie?
                    </h3>
                    <p className="text-gray-300 text-sm font-medium mt-0.5 drop-shadow-sm">
                      90% match based on previous tags.
                    </p>
                  </div>
                </div>
              </div>
            </div>

            {/* Action Buttons */}
            <div className="p-4 flex flex-col gap-3">
              <button className="flex w-full cursor-pointer items-center justify-center rounded-xl h-12 px-4 bg-primary hover:bg-primary/90 transition-all text-white text-base font-bold tracking-wide shadow-lg shadow-primary/25 gap-2 active:scale-[0.98]">
                <span className="material-symbols-outlined text-[20px]">
                  check_circle
                </span>
                Yes, Confirm Match
              </button>
              <div className="grid grid-cols-2 gap-3">
                <button className="flex w-full cursor-pointer items-center justify-center rounded-xl h-10 px-3 bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 text-gray-900 dark:text-white text-sm font-semibold transition-colors gap-2 active:scale-[0.98]">
                  <span className="material-symbols-outlined text-[18px]">
                    person_search
                  </span>
                  Search Tree
                </button>
                <button className="flex w-full cursor-pointer items-center justify-center rounded-xl h-10 px-3 bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 text-gray-900 dark:text-white text-sm font-semibold transition-colors gap-2 active:scale-[0.98]">
                  <span className="material-symbols-outlined text-[18px]">
                    person_add
                  </span>
                  Invite New
                </button>
              </div>
              <button className="mt-1 text-center text-xs font-medium text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors py-2">
                Ignore or not a relative
              </button>
            </div>
          </div>
        </div>

        {/* Context Photos Grid */}
        <div className="px-4 pb-20">
          <div className="flex items-center justify-between mb-3 px-1">
            <h3 className="text-gray-900 dark:text-white font-bold text-base">
              Appears in these photos
            </h3>
            <span className="text-xs font-semibold text-primary bg-primary/10 px-2 py-1 rounded-md">
              12 Photos
            </span>
          </div>
          <div className="grid grid-cols-3 gap-2">
            {CONTEXT_PHOTOS.map((item, index) => (
              <div
                key={index}
                className="aspect-square rounded-lg overflow-hidden relative group cursor-pointer"
              >
                <div
                  className="w-full h-full bg-cover bg-center transition-transform duration-500 group-hover:scale-110"
                  style={{ backgroundImage: `url("${item.img}")` }}
                ></div>
                <div className="absolute inset-0 bg-black/20 group-hover:bg-black/0 transition-colors"></div>
                {item.tags && (
                  <div className="absolute bottom-1 right-1">
                    <span className="material-symbols-outlined text-white drop-shadow-md text-[16px]">
                      face
                    </span>
                  </div>
                )}
              </div>
            ))}

            {/* View All Button */}
            <div className="aspect-square rounded-lg bg-gray-100 dark:bg-gray-800 flex flex-col items-center justify-center text-gray-500 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors cursor-pointer active:scale-95">
              <span className="material-symbols-outlined text-[24px]">
                grid_view
              </span>
              <span className="text-[10px] font-bold mt-1">View All</span>
            </div>
          </div>
          <p className="mt-3 text-xs text-gray-500 dark:text-gray-500 flex items-center gap-1.5 justify-center opacity-80 mt-6">
            <span className="material-symbols-outlined text-[14px]">lock</span>
            Biometric data is private to this tree.
          </p>
        </div>
      </div>
      <BottomNav />
    </div>
  );
}

export default IdentityTaggingScreen;
