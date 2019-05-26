# Rapid Movie Test 

<img src="https://ai.github.io/size-limit/logo.svg" align="right"
     title="Size Limit logo by Anton Lovchikov" width="120" height="178">

Size Limit is a linter for your JS application or library performance.
It calculates the real cost of your JS for end users and throws an error
if the cost exceeds the limit.

* Size Limit calculates **the time** it would take a browser
  **to download and execute** your JS. Time is a much more accurate
  and understandable metric compared to the size in bytes.
* Size Limit calculations include **all dependencies and polyfills**
  used in your JS.
* Add Size Limit to **Travis CI**, **Circle CI**, or another CI system
  to know if a pull request adds a massive dependency.
