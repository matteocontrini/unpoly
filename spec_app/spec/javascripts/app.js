const express = require('express');
const app = express();
const opn = require('opn')

const { execSync } = require('child_process')
// Can't use __dirname while /spec is a symlink
const cwd = execSync('pwd').toString().trim()

app.use(express.static(cwd))

app.listen(3000, function(){
  console.log("Unpoly specs serving on http://localhost:3000.")
  console.log("Press CTRL+C to quit.")
  opn('http://localhost:3000')
});

app.get('/', function(req, res){
  res.sendFile(cwd + '/spec/menu.html');
});

app.get('/specs', function(req, res){
  res.sendFile(cwd + '/spec/runner.html');
});
