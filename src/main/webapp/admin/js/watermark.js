/**
 * 
 */
!function(n,t){"object"==typeof exports&&"object"==typeof module?module.exports=t():"function"==typeof define&&define.amd?define([],t):"object"==typeof exports?exports.watermark=t():n.watermark=t()}(window,function(){return r={},u.m=e=[function(n,t,e){n.exports=e(1).default},function(n,t,e){"use strict";e.r(t);var r={};e.r(r),e.d(r,"atPos",function(){return s}),e.d(r,"lowerRight",function(){return g}),e.d(r,"upperRight",function(){return y}),e.d(r,"lowerLeft",function(){return v}),e.d(r,"upperLeft",function(){return m}),e.d(r,"center",function(){return w});var u={};function c(n){return n}function f(n){return(f="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(n){return typeof n}:function(n){return n&&"function"==typeof Symbol&&n.constructor===Symbol&&n!==Symbol.prototype?"symbol":typeof n})(n)}function o(n,t){for(var e,r=[],u=0;u<n.length;u++){var o=n[u],i=("string"===f(e=o)?a:e instanceof Image?c:l)(o,t);r.push(i)}return Promise.all(r)}function a(t,n){var e=new Image;return"function"==typeof n&&n(e),new Promise(function(n){e.onload=function(){return n(e)},e.src=t})}function l(e){var r=new FileReader;return new Promise(function(n){var t=new Image;r.onloadend=function(){return function(n,t,e){n.onload=function(){return e(n)},n.src=t}(t,r.result,n)},r.readAsDataURL(e)})}function i(n,t){var e=new Image;return"function"==typeof t&&(e.onload=t),e.src=n,e}function d(n,t){return function(n,t){var e=t.getContext("2d");return t.width=n.width,t.height=n.height,e.drawImage(n,0,0),t}(n,t.pop())}e.r(u),e.d(u,"atPos",function(){return b}),e.d(u,"lowerRight",function(){return x}),e.d(u,"lowerLeft",function(){return O}),e.d(u,"upperRight",function(){return j}),e.d(u,"upperLeft",function(){return S}),e.d(u,"center",function(){return P});var h=/^data:([^;]+);base64,(.*)$/;var p=function(){for(var n=arguments.length,t=new Array(n),e=0;e<n;e++)t[e]=arguments[e];return function(n){return t.reduce(function(n,t){return t.call(null,n)},n)}}(function(n){return h.exec(n).slice(1)},function(n){return[function(n){return window.atob(n)}(n[1]),n[0]]},function(n){return new Blob([function(n){for(var t=n.length,e=new Uint8Array(t),r=0;r<t;r++)e[r]=n.charCodeAt(r);return e}(n[0])],{type:n[1]})});function s(r,u,o){return o=o||1,function(n,t){var e=n.getContext("2d");return e.save(),e.globalAlpha=o,e.drawImage(t,r(n,t),u(n,t)),e.restore(),n}}function g(n){return s(function(n,t){return n.width-(t.width+10)},function(n,t){return n.height-(t.height+10)},n)}function y(n){return s(function(n,t){return n.width-(t.width+10)},function(n,t){return 10},n)}function v(n){return s(function(n,t){return 10},function(n,t){return n.height-(t.height+10)},n)}function m(n){return s(function(n,t){return 10},function(n,t){return 10},n)}function w(n){return s(function(n,t){return(n.width-t.width)/2},function(n,t){return(n.height-t.height)/2},n)}function b(r,u,o,i,c,f){return f=f||1,function(n){var t=n.getContext("2d");t.save(),t.globalAlpha=f,t.fillStyle=c,t.font=i;var e=t.measureText(o);return t.fillText(o,r(n,e,t),u(n,e,t)),t.restore(),n}}function x(n,t,e,r,u){return b(function(n,t){return n.width-(t.width+10)},function(n){return u||n.height-10},n,t,e,r)}function O(n,t,e,r,u){return b(function(){return 10},function(n){return u||n.height-10},n,t,e,r)}function j(n,t,e,r,u){return b(function(n,t){return n.width-(t.width+10)},function(){return u||20},n,t,e,r)}function S(n,t,e,r,u){return b(function(){return 10},function(){return u||20},n,t,e,r)}function P(n,t,e,r,u){return b(function(n,t,e){return e.textAlign="center",n.width/2},function(n,t,e){return e.textBaseline="middle",n.height/2},n,t,e,r)}var A=r,R=u;function I(t,e){return Object.keys(e).forEach(function(n){return t[n]=e[n]}),t}var L,U=(L=[],{pop:function(){return 0===this.length&&L.push(document.createElement("canvas")),L.pop()},get length(){return L.length},release:function(n){n.getContext("2d").clearRect(0,0,n.width,n.height),L.push(n)},clear:function(){L.splice(0,L.length)},get elements(){return L}});e.d(t,"default",function(){return T});var _={init:function(){},type:"image/png",encoderOptions:.92};function C(n){return I(function(n){return I({},n)}(_),n)}function M(n,t,e){var r=n.canvas,u=n.sources,o=function(n,t){var e=1<arguments.length&&void 0!==t?t:{type:"image/png",encoderOptions:.92};return n.toDataURL(e.type,e.encoderOptions)}(r,e);return u.forEach(t.release),o}function T(e){var r=2<arguments.length&&void 0!==arguments[2]?arguments[2]:null,u=C(1<arguments.length&&void 0!==arguments[1]?arguments[1]:{});return r=r||o(e,u.init),{dataUrl:function(t){var n=this.then(function(n){return function(n,t){return n.map(function(n){return d(n,t)})}(n,U)}).then(function(n){return function(n,t){return{canvas:n.apply(null,t),sources:t}}(t,n)}).then(function(n){return M(n,U,{type:u.type,encoderOptions:u.encoderOptions})});return T(e,u,n)},load:function(t,e){var n=this.then(function(n){return o([n].concat(t),e)});return T(t,u,n)},render:function(){var n=this.then(function(n){return o([n])});return T(e,u,n)},blob:function(n){var t=this.dataUrl(n).then(p);return T(e,u,t)},image:function(n){var t=this.dataUrl(n).then(i);return T(e,u,t)},then:function(){for(var n=arguments.length,t=new Array(n),e=0;e<n;e++)t[e]=arguments[e];return r.then.apply(r,t)}}}T.image=A,T.text=R,T.destroy=function(){return U.clear()}}],u.c=r,u.d=function(n,t,e){u.o(n,t)||Object.defineProperty(n,t,{enumerable:!0,get:e})},u.r=function(n){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(n,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(n,"__esModule",{value:!0})},u.t=function(t,n){if(1&n&&(t=u(t)),8&n)return t;if(4&n&&"object"==typeof t&&t&&t.__esModule)return t;var e=Object.create(null);if(u.r(e),Object.defineProperty(e,"default",{enumerable:!0,value:t}),2&n&&"string"!=typeof t)for(var r in t)u.d(e,r,function(n){return t[n]}.bind(null,r));return e},u.n=function(n){var t=n&&n.__esModule?function(){return n.default}:function(){return n};return u.d(t,"a",t),t},u.o=function(n,t){return Object.prototype.hasOwnProperty.call(n,t)},u.p="",u(u.s=0);function u(n){if(r[n])return r[n].exports;var t=r[n]={i:n,l:!1,exports:{}};return e[n].call(t.exports,t,t.exports,u),t.l=!0,t.exports}var e,r});