# vlw project

<h4><span>STATUS: </span>COMING SOON!</h4><br />
lua project with <span style="color:skyblue;">+conky</span></br></br>

<b style="color:goldenrod;">[use loaded_modules in +lua scripts]</b>
<pre>
require "modules.init";
require "&lt;pkg&gt;";
</pre>

<b style="color:goldenrod;">[loaded packages from local system]</b>
<pre>
bash loaded_modules.sh -s json,toml
bash loaded_modules.sh -L /usr/local/share/lua/5.3/ json,toml
</pre>

<b style="color:goldenrod;">[get source before compile]</b>
<pre>
bash loaded_modules.sh -d -s json,toml
bash loaded_modules.sh -d -L /usr/local/share/lua/5.3/ json,toml
</pre>

<b style="color:goldenrod;">[remove packages from modules]</b>
<pre>
bash loaded_modules.sh -r json,toml
</pre>

<b style="color:goldenrod;">[reload packages from local system]</b>
<pre>
bash loaded_modules.sh -r json,toml -d -s json,toml
</pre>
