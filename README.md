# vlw project

<h4><span>STATUS: </span>COMING SOON!</h4><br />
lua project with <span style="color:skyblue;">+conky</span></br></br>

<b style="color:goldenrod;">[use loaded_modules in +lua scripts]</b>
<pre>
require "modules.init";
require "modules.&lt;pkg&gt;";
require "&lt;pkg&gt;";
</pre>

<b style="color:goldenrod;">[loaded packages from local system]</b>
<pre>
bash loaded_modules.sh -s &lt;pkg&gt;,&lt;pkg&gt;
bash loaded_modules.sh -L /usr/local/share/lua/5.3/ &lt;pkg&gt;,&lt;pkg&gt;
</pre>

<b style="color:goldenrod;">[get source before compile]</b>
<pre>
bash loaded_modules.sh -d -s &lt;pkg&gt;,&lt;pkg&gt;
bash loaded_modules.sh -d -L /usr/local/share/lua/5.3 &lt;pkg&gt;,&lt;pkg&gt;
bash loaded_modules.sh -d -L /usr/local/share/lua/5.3/ &lt;pkg&gt;,&lt;pkg&gt;
bash loaded_modules.sh -d -L /usr/share/lua/5.3:/usr/local/share/lua/5.3 &lt;pkg&gt;,&lt;pkg&gt;
DEVMODE=1 bash loaded_modules.sh -s &lt;pkg&gt;,&lt;pkg&gt;
DEVMODE=1 bash loaded_modules.sh -L /usr/local/share/lua/5.3 &lt;pkg&gt;,&lt;pkg&gt;
DEVMODE=1 bash loaded_modules.sh -L /usr/local/share/lua/5.3/ &lt;pkg&gt;,&lt;pkg&gt;
DEVMODE=1 bash loaded_modules.sh -L /usr/share/lua/5.3:/usr/local/share/lua/5.3 &lt;pkg&gt;,&lt;pkg&gt;
</pre>

<b style="color:goldenrod;">[remove packages from modules]</b>
<pre>
bash loaded_modules.sh -r &lt;pkg&gt;,&lt;pkg&gt;
</pre>

<b style="color:goldenrod;">[reload packages from local system]</b>
<pre>
bash loaded_modules.sh -r &lt;pkg&gt;,&lt;pkg&gt; -d -s &lt;pkg&gt;,&lt;pkg&gt;
</pre>

<b style="color:goldenrod;">[buggy]</b>
<pre>
DEVMODE=1 bash loaded_modules.sh -d -d -d -d -d -d
DEVMODE=1 bash loaded_modules.sh -r &lt;pkg&gt;,&lt;pkg&gt; -d -d -d -d -d -d -h
DEVMODE=1 bash loaded_modules.sh -r &lt;pkg&gt;,&lt;pkg&gt; -d -d -d -d -d -d
DEVMODE=1 bash loaded_modules.sh -d -d -d -d -d -d -h
DEVMODE=1 bash loaded_modules.sh -d -d -d -d -d -d -r &lt;pkg&gt;,&lt;pkg&gt; -h
DEVMODE=1 bash loaded_modules.sh -d -d -d -d -d -d -r &lt;pkg&gt;,&lt;pkg&gt;
</pre>
