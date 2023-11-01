'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "0988ee644574be4f725cee18f690f842",
"assets/AssetManifest.json": "d7f803e946170dd8db402ded4f6bb484",
"assets/assets/audios/1.mp3": "46d6fd0d5339508ca3b8ef909fef1010",
"assets/assets/back/1.svg": "68b1bd18fcacdb89a4c4d343a5f74ebe",
"assets/assets/back/2.svg": "dedd68574c7b72253e8f45d2fe2bc1e7",
"assets/assets/back/3.svg": "6ffa92e9b7a7ce4304ae7f82cf478f5b",
"assets/assets/back/4.svg": "eec5df47eeb65b26f4c75d64fec037c1",
"assets/assets/back/5.svg": "ca7e5a202c2730800e87853fef263ebb",
"assets/assets/background/king.svg": "9dd96340c63c4d162443d00a66f4fb3a",
"assets/assets/background/logo.png": "5f150d7da2824db77adcf562aa5c6b62",
"assets/assets/background/slave.svg": "4ffb598c238ebeee901ef9727160ed59",
"assets/assets/equal/1.svg": "203102c9ab0576f53d915013bb74d68e",
"assets/assets/equal/2.svg": "46a37890e8292ddaa1999d25dbc14d1e",
"assets/assets/equal/3.svg": "d936b8d849feeb8caabbced5606d47a2",
"assets/assets/king/1.svg": "15ac1977d220d0ae42f956c6644413b2",
"assets/assets/king/2.svg": "856516ca5912bda4e21c240fc5068005",
"assets/assets/king/3.svg": "15bbb95831f6cae7cd46324b369ecaf1",
"assets/assets/king/4.svg": "cd1876e54e6db9083a83b7ef882f34a0",
"assets/assets/king/5.svg": "d434d30ad2714732857442e45f73cc81",
"assets/assets/lose/1.svg": "f20b7f3e996f21b9513aab46ae6b5436",
"assets/assets/lose/2.svg": "be9d974992b784bd59496f89f57a7008",
"assets/assets/lose/3.svg": "68ba4dd41766d2b90f83f5bc5640cdb6",
"assets/assets/lose/4.svg": "01a461864d77682e73d6df64bbd8a4df",
"assets/assets/map/hat.svg": "744889c80f559e813dcc195e0ec235cd",
"assets/assets/map/mongkot.svg": "ea49a9b4b1fcacf551cde226f635e0e4",
"assets/assets/noLife/1.svg": "5e9d944f01db3505dbd85657c202eb9d",
"assets/assets/noLife/2.svg": "6f1d7e557f40ae7130f1fc2f17b1f4ac",
"assets/assets/noLife/3.svg": "b6d3f09a0644c725ab8c100ed8efc134",
"assets/assets/setting/1.svg": "eba97bbf7253f18e2850acb2c734b064",
"assets/assets/setting/2.svg": "e75f7b56684efba63a698b6772d6af08",
"assets/assets/setting/appsara.svg": "994b6e069e45fb9463a649481c864b28",
"assets/assets/shield/1.svg": "2b8d0bbc688f4c18c759e6d5d5cbe3af",
"assets/assets/shield/2.svg": "4306fd483f94c944584ca886ab94b279",
"assets/assets/slave/1.svg": "3aacb33fc2ca9fe72512f65b19148cdc",
"assets/assets/slave/2.svg": "b5bc7bb5322074e5edd9a8be8f51cc8f",
"assets/assets/slave/3.svg": "cb7cfab394573abe1972acf8eda0e953",
"assets/assets/slave/4.svg": "7d76aebfb4d371be6ea00c51d55726eb",
"assets/assets/slave/5.svg": "01e16b2d002ba57da73aae9d1c2e8878",
"assets/assets/soldier/1.svg": "b66a7d3b0f122f73a3186b13ac39307d",
"assets/assets/soldier/2.svg": "6bd4865d905e2178d74d836566707d0b",
"assets/assets/soldier/3.svg": "ff74451e575c282ce94f0a3d1b93cf7a",
"assets/assets/soldier/4.svg": "b662ff81df6b545a76630997c00e892f",
"assets/assets/soldier/5.svg": "e31103ab25dd1df99d6b6f4a70b55333",
"assets/assets/soldier/6.svg": "a24da3343c5e1860ac98dc8b2c398c5f",
"assets/assets/soldier/7.svg": "527114c62e9aad4d326387cf67ba6ced",
"assets/assets/sword/1.svg": "7d6dd74787c24da6876a49b25c0dd287",
"assets/assets/sword/2.svg": "4c8624ad4070a0cacef94f076a729684",
"assets/assets/win/1.svg": "0528a5169947f911acc6af76a7cca676",
"assets/assets/win/2.svg": "325e2f463b229e0f20f7f195c511963e",
"assets/assets/win/3.svg": "28b877d1447f09bbefec5af27c7be93a",
"assets/assets/win/4.svg": "fc256e5cb0d40d9eaf30ed0cb6015cb2",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "a03a71945ca885aab605ae2a222d69f7",
"assets/NOTICES": "4fd0f4d86225f651a6bcb93087fc8ecd",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "8c84ee8b0ca292cd80e56a915c929dbc",
"/": "8c84ee8b0ca292cd80e56a915c929dbc",
"main.dart.js": "6d25a942f947525b7def5cd9ad45dd44",
"manifest.json": "bcbbf30ac0245521648313733d3df3ae",
"splash/img/dark-1x.png": "5f0df05929bb52a2d82a6753511b99d7",
"splash/img/dark-2x.png": "302d26d36d571ba99c38400f58f186c4",
"splash/img/dark-3x.png": "e29c66a4f4d4dbe55bde98c56b56315f",
"splash/img/dark-4x.png": "43c91e8ffc2efbd5375b1d6834e2f230",
"splash/img/light-1x.png": "5f0df05929bb52a2d82a6753511b99d7",
"splash/img/light-2x.png": "302d26d36d571ba99c38400f58f186c4",
"splash/img/light-3x.png": "e29c66a4f4d4dbe55bde98c56b56315f",
"splash/img/light-4x.png": "43c91e8ffc2efbd5375b1d6834e2f230",
"version.json": "bdfb07f8b764b20fbe7b855a26a26b2d"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
