import http from "k6/http";
import { sleep } from "k6";

export let options = {
  stages: [
    { duration: '10s', target: 5 },
    { duration: '10s', target: 10 },
    { duration: '10s', target: 20 },

    { duration: '10s', target: 40 },
    { duration: '10s', target: 80 },
    { duration: '10s', target: 100 },
  ],
};

export default function() {

    let url = __ENV.URL;
    let responses = http.batch([
        ['GET',  url, null, { tags: { ctype: 'html' } }],
        ['GET', url + '/styles.09e2c710755c8867a460.css', null, { tags: { ctype: 'css' } }],
        ['GET', url + '/runtime.e227d1a0e31cbccbf8ec.js', null, { tags: { ctype: 'js' } }],
        ['GET', url + '/polyfills.a4021de53358bb0fec14.js', null, { tags: { ctype: 'js' } }],
        ['GET', url + '/main.fa75e204e3d74a4a8af4.js', null, { tags: { ctype: 'js' } }]
    ]);
    sleep(3);
    // let response = http.get("https://mysold001-webuiproxy.azurewebsites.net");
    // let response = http.get("https://cda564341f5b.ngrok.io/dashboard");
};