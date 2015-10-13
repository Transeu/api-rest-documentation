<h1 id="common-api-rest-standards">Common API REST standards</h1>

<h2 id="requests">Requests</h2>

<h3 id="accept-media-types">Accept media types</h3>

<p>All request to TransAPI must contain proper <code>Accept</code> header, as it's based on <a href="http://stateless.co/hal_specification.html">Json HAL</a>.</p>

<p>As HAL language is used, proper <code>Accept</code> header is as follows:</p>

<pre><code>Accept: application/hal+json
</code></pre>

<h4 id="json-hypertext-application-language-hal">JSON Hypertext Application Language (HAL)</h4>

<p>HAL is a generic media type with which Web APIs can be developed and exposed
as series of links. Clients of these APIs can select links by their link
relation type and traverse them in order to progress through the application.</p>

<p>For more in-depth HAL standard specification see <a href="https://tools.ietf.org/html/draft-kelly-json-hal-07">draft-kelly-json-hal-07</a>.</p>

<h3 id="content-type">Content-Type</h3>

<p>For <code>POST</code>/<code>PUT</code>/<code>PATCH</code> request methods, content should be well-formed JSON.</p>

<p>Also proper <code>Content-Type</code> header is required:</p>

<pre><code>Content-Type: application/json
</code></pre>

<h3 id="collection-filtering">Collection filtering</h3>

<p>TransAPI uses JSON filter syntax, there are few reasons why JSON was appointed to standard:</p>

<ul>
<li>easy to implement in any programing language,</li>
<li>easily creates nested structure,</li>
<li>short,</li>
<li>human-readable.</li>
</ul>

<p>Operators examples:</p>

<ul>
<li><p>filter out elements meeting range criteria</p>

<blockquote>
  <p><code>{ field: { $gt: value1, $lt: value2 } }</code></p>
</blockquote></li>
<li><p>filter out elements present in given array:</p>

<blockquote>
  <p><code>{ field: { $in: [&lt;value1&gt;, &lt;value2&gt;, ... &lt;valueN&gt; ] } }</code></p>
</blockquote></li>
</ul>

<p>TransAPI has adopted MongoDB filtering syntax. More information regarding filters can be found in <a href="http://docs.mongodb.org/manual/reference/method/db.collection.find/">MongoDB filtering documentation</a>.</p>

<p><strong>IMPORTANT</strong>: TransAPI uses only embedded filter notation. Filters also don't filter by exact matches of entity fields.</p>

<p>Example of load collection filter by unloading location:</p>

<p><code>/loads?filter={"unloading_place":{"address":{"country":"PL"}}}</code>.</p>

<h3 id="collection-sorting">Collection sorting</h3>

<p>To sort collection in TransAPI, request must contain <code>sort</code> param in query string.</p>

<p>TransAPI has adopted MongoDB sorting syntax. More information regarding sorting can be found in <a href="http://docs.mongodb.org/manual/reference/method/cursor.sort/">MongoDB sorting documentation</a>.</p>

<p>Example of ascending sort vehicles by loading country:</p>

<p><code>/vehicles?sort={"loading_place.address.country":-1}}}</code></p>

<h3 id="read-specified-fields-from-resource">Read specified fields from resource</h3>

<p>To read specified fields from resource and embedded resources use <code>fields</code> parameter. It can be used only for GET method.
TransAPI has adopted MongoDB projection syntax. More information regarding sorting can be found in <a href="http://docs.mongodb.org/manual/tutorial/project-fields-from-query-results/">MongoDB projection documentation</a>.</p>

<p>Example of including only load id:</p>

<p><code>/loads/123456789?fields={"id":1}}}</code></p>

<h2 id="data-formats">Data formats</h2>

<h4 id="date-time">Date time</h4>

<p>Timestamps are returned in <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a> format as Coordinated Universal Time (UTC) with zero offset:</p>

<p><code>YYYY-MM-DDTHH:MM:SS+00:00</code></p>

<h4 id="date">Date</h4>

<p>Date format is documented in <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a></p>

<h4 id="country">Country</h4>

<p>Country format is documented in <a href="http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2">ISO_3166-1</a></p>

<h4 id="boolean">Boolean</h4>

<p>Boolean values must be passed as boolean <code>true</code>/<code>false</code>. Do not use strings (<code>"true"/"false"</code>) or numbers (<code>0</code>/<code>1</code>).</p>

<h4 id="numeric-fields">Numeric fields</h4>

<p>Numeric fields must be passed as integers or floats, not strings. Example:</p>

<pre><code>{
  "id": 123,
  "name": "Product",
  "price": 123.23
}
</code></pre>

<h4 id="fields-without-value">Fields without value</h4>

<p>Field without defined value should be passed as <code>null</code> and are returned as <code>null</code>. Avoid empty strings (<code>""</code>), <code>0</code> or false. Example:</p>

<pre><code>{
  "id": 123,
  "name": "John",
  "telephone": null
}
</code></pre>

<h2 id="response">Response</h2>

<h3 id="error-responses">Error responses</h3>

<p>For error responses TransAPI uses format documented in <a href="https://tools.ietf.org/html/draft-nottingham-http-problem-07">API Problem documentation</a>.</p>

<pre><code>HTTP/1.1 403 Forbidden
Content-Type: application/problem+json

{
    "type": "http://api-problem.domain.com/some-url.html",
    "title": "Forbidden",
    "status": 403,
    "detail": "some detail"
}
</code></pre>

<p>API Problem may contain following fields:</p>

<ul>
<li>type: URL to documentation page. If not presented, its value is assumed to be "about:blank",</li>
<li>title: A short summary of the problem type. It does not change between occurrences of the problem,</li>
<li>status: HTTP status code, same as in header,</li>
<li>detail: More detailed explanation specific to given occurrence of the problem.</li>
</ul>

<p>Response may also contain custom fields.</p>

<p><strong>IMPORTANT</strong> Problem details are not a debugging tool for the underlying implementation; rather, they are a way to expose general information about the HTTP interface itself.</p>

<h4 id="validation-errors">Validation errors</h4>

<p>Example of filter validation error response:</p>

<pre><code>HTTP/1.1 422 Unprocessable Entity
Content-Type: application/problem+json

{
    "detail": "Failed Filter Parameter Validation",
    "status": 422,
    "title": "Invalid Filter Parameter",
    "type": "http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html",
    "validation_messages": {
        "message": {
            "isEmpty": "Value is required and can't be empty"
        },
        "name": {
            "regexNotMatch": "Invalid name supplied."
        }
    }
}
</code></pre>

<h2 id="http-status-codes">HTTP Status Codes</h2>

<h3 id="201-created"><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.2.2">201 Created</a></h3>

<p>After creating new entity.</p>

<h3 id="204-no-content"><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.2.5">204 No Content</a></h3>

<p>After deleting entity.</p>

<h3 id="403-forbidden"><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.4">403 Forbidden</a></h3>

<p>The request was a legal request, but the server is refusing to respond to it.</p>

<h3 id="404-not-found"><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.5">404 Not Found</a></h3>

<p>When trying to get not existing entity.</p>

<h3 id="405-method-not-allowed"><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.6">405 Method Not Allowed</a></h3>

<p>A request was made to a resource with request method not supported by that resource.</p>

<h3 id="409-conflict"><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.10">409 Conflict</a></h3>

<p>When trying to POST/PUT/PATCH entity and given value already exists.</p>

<h3 id="422-unprocessable-entity"><a href="https://tools.ietf.org/html/rfc4918#section-11.2">422 Unprocessable Entity</a></h3>

<p>The request was well-formed but server was unable to process it due to semantic errors.</p>
