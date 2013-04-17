KISSY.config({
  packages: [
    {
      name: 'velocity',
      path: '../../../',
      tag: 20121210
    }
  ]
});

KISSY.use('velocity/1.1/index, velocity/1.1/parse', function(S, Compile, Parser){
  window.Compile = Compile;
  window.Parser = Parser;
  S.getScript('./spec.js?' + S.now, function(){
    mocha.run();
  });
});
