'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/android-icon-144x144.png": "05e5043ff80f3515f29dad0b1ff7da93",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/apple-icon-57x57.png": "bc4d1acab7bc5d837b3f598c9be2df60",
"icons/apple-icon-152x152.png": "75734d3cb2d013b89d1d3db13c9dc170",
"icons/apple-icon-72x72.png": "656aa967e4308c713facae3447773cc6",
"icons/apple-icon-120x120.png": "0bf589cbb3dff21e8c071e952ff8ac2b",
"icons/favicon-16x16.png": "1851e0f198c6b691859f33ad8aa58d91",
"icons/favicon.ico": "97bfc75a853aa4a021140de4e42003de",
"icons/manifest.json": "905ec0787f894755afb599220bb80e9e",
"icons/ms-icon-150x150.png": "8dbe1348d1035b4272c4f466895532e1",
"icons/ms-icon-144x144.png": "05e5043ff80f3515f29dad0b1ff7da93",
"icons/apple-icon-60x60.png": "859608d23ab8e9bbd79e1041e1e306bf",
"icons/apple-icon-114x114.png": "cc2fab80d3a705a42bf3ebeed54b4771",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/ms-icon-70x70.png": "49fab08ce39171466e02f3b1e0d606a1",
"icons/apple-icon-144x144.png": "05e5043ff80f3515f29dad0b1ff7da93",
"icons/apple-icon-precomposed.png": "46144ac99343d1c27c3bbc1e195f0b8f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/ms-icon-310x310.png": "9c6bc030628f38450221822bae6944ab",
"icons/android-icon-72x72.png": "656aa967e4308c713facae3447773cc6",
"icons/apple-icon.png": "46144ac99343d1c27c3bbc1e195f0b8f",
"icons/favicon-96x96.png": "d10e010d8b73d4d66826d215d6a8e096",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/android-icon-36x36.png": "1374839b6a024cd4ac94b0a02fa15e98",
"icons/apple-icon-180x180.png": "edae94bf6eafed4dc777da68455b6e25",
"icons/android-icon-48x48.png": "314f41658c323ddae773d2a7c924bf2f",
"icons/favicon-32x32.png": "5a9ddb8f0f5fb630e3ed02d78ea09b95",
"icons/apple-icon-76x76.png": "ab82ac58f76917db969e05622824c83d",
"icons/android-icon-96x96.png": "d10e010d8b73d4d66826d215d6a8e096",
"icons/android-icon-192x192.png": "7ec2a1d466c398390b6f7825a043f09e",
"favicon-old.png": "5dcef449791fa27946b3d35ad8803796",
"favicon-16x16.png": "c8556b1971fc13badfb0c873b6358aa6",
"manifest.json": "9ae90b43d4adc6c6d077ff3e48321289",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"index.html": "0e2d9c066237f3d10ae63d9391389d9e",
"/": "0e2d9c066237f3d10ae63d9391389d9e",
"version.json": "90029b39c6bc4258da3515562da9a145",
"main.dart.js": "0867f435e49cd7fffe9334ff73f2b56d",
"assets/FontManifest.json": "f482084123cefe8117c72001cbdc463a",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/NOTICES": "17d814599dc08e54ac78317a1c0dfa05",
"assets/AssetManifest.json": "21bd37fe2f57008194ec42f1632a7d9b",
"assets/assets/google_fonts/Roboto-Regular.ttf": "f36638c2135b71e5a623dca52b611173",
"assets/assets/google_fonts/Roboto-BlackItalic.ttf": "c470ca2b5b4f4437a3fe71b113a289a2",
"assets/assets/google_fonts/Roboto-LightItalic.ttf": "2ffc058ddedacfeaa23542026c8108e2",
"assets/assets/google_fonts/NotoSansTC-Black.otf": "588891ada594cfc27ec42faf071e49af",
"assets/assets/google_fonts/Roboto-Bold.ttf": "9ece5b48963bbc96309220952cda38aa",
"assets/assets/google_fonts/NotoSansTC-Bold.otf": "74013d120e62f958c56a824f9a42c030",
"assets/assets/google_fonts/Roboto-Medium.ttf": "b2d307df606f23cb14e6483039e2b7fa",
"assets/assets/google_fonts/Roboto-Thin.ttf": "4f0b85f5b601a405bdc7b23aad6d2a47",
"assets/assets/google_fonts/NotoSansTC-Medium.otf": "ed6eb8976a526c6c1d32193b38dc4752",
"assets/assets/google_fonts/Roboto-Black.ttf": "301fe70f8f0f41c236317504ec05f820",
"assets/assets/google_fonts/Roboto-Italic.ttf": "465d1affcd03e9c6096f3313a47e0bf5",
"assets/assets/google_fonts/NotoSansTC-Regular.otf": "184b96c5589fe8826ffdb9ddcebb9ff5",
"assets/assets/google_fonts/NotoSansTC-Thin.otf": "c60983ca992b63960c61a60ef7ddefaf",
"assets/assets/google_fonts/Roboto-ThinItalic.ttf": "7384da64612787e3662872e9d19cbc2d",
"assets/assets/google_fonts/Roboto-MediumItalic.ttf": "cabdb4a12e5de710afde298809306937",
"assets/assets/google_fonts/NotoSansTC-Light.otf": "2ab52b58c8b9ff3e95dcd58dcde9d33d",
"assets/assets/google_fonts/Roboto-Light.ttf": "6090d256d88dcd7f0244eaa4a3eafbba",
"assets/assets/google_fonts/OFL.txt": "2c309aad324a15dea6c68973d9bb7cf0",
"assets/assets/google_fonts/Roboto-BoldItalic.ttf": "0be9fa8f2863998d1e52c84165976880",
"assets/assets/images/IMG_1392.JPG": "dad32cc1308a0180984f369ea4b0c463",
"assets/assets/images/cbtc-bj.jpg": "768f7d8f41f070bf5b886033ab4b34d8",
"assets/assets/images/mrIP.JPG": "75040b59ca9d193d81e5eb2c28a55f88",
"assets/assets/images/divider-g8f3e8fda8_640.png": "413ae7cd93c7afea6f307e3c3b70ced2",
"assets/assets/images/BountifulGraceChurch.jpg": "edc47601b204472d82cbb929c0c1fd6f",
"assets/assets/images/ArJj0pMqJls.jpg": "085cc90578dea9b4980822133b9a204f",
"assets/assets/images/anchk-logo.PNG": "64e6d84b4ca011dd835fc15da67d5536",
"assets/assets/images/anchk-logo%2520(1).PNG": "64e6d84b4ca011dd835fc15da67d5536",
"assets/assets/images/logo%25202.JPG": "a5981fa8bf70fa6e186908bc72852225",
"assets/assets/images/gCwHitVRirI.jpg": "1233d0d1f979cb0625b5adea07f0e25b",
"assets/assets/images/preachers.jpg": "2f24e4fc2a7e45bf5599ff4e49f7bd30",
"assets/assets/images/Anchk.png": "fd384611924ae693a5a9b2d5dd774b28",
"assets/assets/images/C2szYJuQymI.jpg": "69ee3dd491bf1e8a63f07d49b4bab8ad",
"assets/assets/images/blueBubbleBG.JPG": "e612aeb6ca4901d636051abc463fbc02",
"assets/assets/images/C_&_M_A_Bountiful_Grace_Church.png": "53dafdf33ca8663aa1f6035397a9e292",
"assets/assets/images/b53oI2p-UrI.jpg": "3adb2fb114f45d8b907399ca634f59ee",
"assets/assets/images/CkjbpbRrRYo.jpg": "5f348c878e4c0a29e12089c8cb298e37",
"assets/assets/images/cbtc.jpg": "34913a7a038968aa6aa911c8165ddf3f",
"assets/assets/images/heng_on_baptist_church.png": "20fc604a980cc7f379d108d6e1ef8432",
"assets/assets/images/map.jpg": "34850d08357689996132c86821e119c0",
"assets/assets/images/cbtc-2x2.jpg": "6ba4c152f96c2a31fe0936fb8b8a8c89",
"assets/assets/images/cbtc3.jpg": "d7721a3503089ce6f2def6d2b04d6b6e",
"assets/assets/images/IMG_1394.JPG": "c8871602974310f5c5d547517355e73d",
"assets/assets/images/PHOTO-2021-10-30-10-22-55.jpg": "db821f5ec8a36b94d8ad734457a4ed52",
"assets/assets/images/Hp8P_CXOQ68.jpg": "ab7a55f77311bc8802108f466e112a09",
"assets/assets/images/IMG_1390.JPG": "8a3ac048bd9c4537e709d119da7fb8c8",
"assets/assets/images/ytbPlayBotton.png": "a29ebc43f2475b4c7235fad683f498d8",
"assets/assets/images/cbtc-123.jpg": "465bbf0e369570113a2bcbc685015d57",
"assets/assets/images/slogon.JPG": "144febb70fa9608e790f94dccf39bcae",
"assets/assets/images/cbtc.png": "58ee7210daed63ab68733c3e1b50866a",
"assets/assets/images/UXP9sR0A0vQ.jpg": "f970499c47d448b4f61f066742bf9c31",
"assets/assets/images/IMG_1391.JPG": "13c26a17980bd6b71c4c191d57eb9ade",
"assets/assets/images/7pc4rNCmEqo.jpg": "9fb7d8ccdad267e7dfcb6d6401db854e",
"assets/assets/images/IMG_1393.JPG": "c657bcb72e73d23e6a8f0df639c105d4",
"assets/assets/images/emailQRcode.PNG": "7b459196f30278653628488081677cc7",
"assets/assets/images/preachers2.jpg": "c0eddaa59aacf75652367152813b00b4",
"favicon-32x32.png": "04d90ba8c0b5dadbfa3aa5c2e57d856c",
"favicon2.png": "5dcef449791fa27946b3d35ad8803796"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
