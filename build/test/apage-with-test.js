// Generated by CoffeeScript 1.9.2

/*! Apage 0.0.11 //// MIT Licence //// http://apage.richplastow.com/ */

(function() {
  var Article, Main, Tudor, dirname, filename, filterLine, marked, ordername, page, renderer, script, style, tidypath, tudor, ª, ªA, ªB, ªE, ªF, ªI, ªN, ªO, ªR, ªS, ªU, ªV, ªX, ªclone, ªhas, ªpopulate, ªtype,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  ªI = 'Apage';

  ªV = '0.0.11';

  ªA = 'array';

  ªB = 'boolean';

  ªE = 'error';

  ªF = 'function';

  ªN = 'number';

  ªO = 'object';

  ªR = 'regexp';

  ªS = 'string';

  ªU = 'undefined';

  ªX = 'null';

  ª = console.log.bind(console);

  ªhas = function(h, n, t, f) {
    if (t == null) {
      t = true;
    }
    if (f == null) {
      f = false;
    }
    if (-1 !== h.indexOf(n)) {
      return t;
    } else {
      return f;
    }
  };

  ªtype = function(x) {
    return {}.toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase();
  };

  ªpopulate = function(candidate, subject, rules, updating) {
    var errors, j, k, key, len, len1, rule, test, type, use, value;
    if (ªO !== ªtype(candidate)) {
      return ["`candidate` is type '" + (ªtype(candidate)) + "' not 'object'"];
    }
    errors = [];
    for (j = 0, len = rules.length; j < len; j++) {
      rule = rules[j];
      key = rule[0], use = rule[1], type = rule[2], test = rule[3];
      value = candidate[key];
      if (void 0 === value) {
        if (updating || void 0 !== use) {
          continue;
        } else {
          errors.push("Missing field '" + key + "' is mandatory");
        }
      } else if (type !== ªtype(value)) {
        errors.push("Field '" + key + "' is type '" + (ªtype(value)) + "' not '" + type + "'");
      } else if (!test.test(value)) {
        errors.push("Field '" + key + "' fails " + ('' + test));
      }
    }
    if (errors.length) {
      return errors;
    }
    for (k = 0, len1 = rules.length; k < len1; k++) {
      rule = rules[k];
      key = rule[0], use = rule[1], type = rule[2], test = rule[3];
      value = candidate[key];
      if (void 0 === value) {
        if (void 0 === subject[key]) {
          subject[key] = use;
        }
      } else {
        subject[key] = value;
      }
    }
  };

  ªclone = function(subject, rules) {
    var j, key, len, out, rule;
    out = {};
    for (j = 0, len = rules.length; j < len; j++) {
      rule = rules[j];
      key = rule[0];
      out[key] = subject[key];
    }
    return out;
  };

  Article = (function() {
    Article.prototype.I = 'Article';

    Article.prototype.toString = function() {
      return "[object " + this.I + "]";
    };

    Article.prototype._rules = {
      config: [['path', void 0, 'string', /^[-.\/a-zA-Z0-9]{1,64}$/], ['raw', '@todo\n=====\n', 'string', /^[^\x00-\x08\x0E-\x1F]{0,10000}$/]]
    };

    function Article(config) {
      var errors, i, j, key, len, line, ref, ref1, value;
      if (config == null) {
        config = {};
      }
      this._config = {};
      if (errors = ªpopulate(config, this._config, this._rules.config)) {
        throw new Error('Invalid `config`:\n  ' + errors.join('\n  '));
      }
      this.path = this._config.path.replace(/^[.\/]+/g, '');
      this.front = [];
      if ('---\n' === this._config.raw.substr(0, 4)) {
        this._config.raw = this._config.raw.split('---\n');
        ref = this._config.raw[1].split('\n');
        for (i = j = 0, len = ref.length; j < len; i = ++j) {
          line = ref[i];
          ref1 = line.split(': '), key = ref1[0], value = ref1[1];
          if (!key || !value) {
            continue;
          }
          if ('title' === key) {
            this.title = value;
          } else {
            this.front.push([key, value]);
          }
        }
        this._config.raw = (this._config.raw.slice(2)).join('---\n');
      }
      this._config.raw = this._config.raw.replace(/^\s+|\s+$/g, '');
      this.title = this.title || (this._config.raw.split('\n'))[0];
      this.html = (marked(this._config.raw)).replace(/\\/g, '\\\\').split('\n');
    }

    Article.prototype.config = function(key, value) {
      var obj;
      switch (arguments.length) {
        case 0:
          return ªclone(this._config, this._rules.config);
        case 1:
          switch (ªtype(key)) {
            case ªS:
              return this._config[key];
            case ªO:
              return ªpopulate(key, this._config, this._rules.config, true);
          }
          break;
        case 2:
          obj = {};
          obj[key] = value;
          return this.config(obj);
      }
    };

    return Article;

  })();

  Main = (function() {
    Main.prototype.I = ªI;

    Main.prototype.V = ªV;

    Main.prototype.toString = function() {
      return "[object " + this.I + "]";
    };

    Main.prototype._rules = {
      config: [['title', 'Untitled', 'string', /^[^\x00-\x1F]{1,24}$/], ['url', false, 'string', /^[-:.\/a-z0-9]{1,64}$/], ['plugin', '', 'string', /^[^\x00-\x08\x0E-\x1F]{0,10000}$/]]
    };

    function Main(config) {
      var errors;
      if (config == null) {
        config = {};
      }
      this._config = {};
      this._articles = [];
      if (errors = ªpopulate(config, this._config, this._rules.config)) {
        throw new Error('Invalid `config`:\n  ' + errors.join('\n  '));
      }
    }

    Main.prototype.config = function(key, value) {
      var obj;
      switch (arguments.length) {
        case 0:
          return ªclone(this._config, this._rules.config);
        case 1:
          switch (ªtype(key)) {
            case ªS:
              return this._config[key];
            case ªO:
              return ªpopulate(key, this._config, this._rules.config, true);
          }
          break;
        case 2:
          obj = {};
          obj[key] = value;
          return this.config(obj);
      }
    };

    Main.prototype.append = function(article) {
      if (!article) {
        return this;
      }
      this._articles.push(new Article(article));
      return this;
    };

    Main.prototype.render = function() {
      return "" + (page(this._config, this._articles));
    };

    return Main;

  })();

  if (ªF === typeof define && define.amd) {
    define(function() {
      return Main;
    });
  } else if (ªO === typeof module && module && module.exports) {
    module.exports = Main;
  } else {
    this[ªI] = Main;
  }

  if (ªF === typeof define && define.amd) {

  } else if (ªO === typeof module && module && module.exports) {
    marked = require('marked');
  } else {
    marked = window.marked;
  }

  renderer = new marked.Renderer;

  renderer.heading = function(text, level) {
    return "<h" + level + ">" + text + "</h" + level + ">\n";
  };

  marked.setOptions({
    renderer: renderer
  });

  page = function(config, articles) {
    var article, i, id, j, k, len, len1, line, out, ref;
    out = ["<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n  <title>" + config.title + "</title>\n  <meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\">\n  <meta name=\"generator\" content=\"" + ªI + " " + ªV + " http://apage.richplastow.com/\">\n  <style>\n    " + (style(config)) + "\n  </style>\n" + (script(config, articles)) + "\n</head>\n<body>\n\n  <nav class=\"nav\" tabindex=\"-1\" onclick=\"this.focus()\">\n    <div class=\"container\">\n    </div>\n  </nav>\n  <div class=\"btn btn-sm btn-close\">×</div>\n\n  <div class=\"container\">\n    <div class=\"col content\"></div>\n  </div>\n"];
    for (i = j = 0, len = articles.length; j < len; i = ++j) {
      article = articles[i];
      id = tidypath(article.path);
      out.push("<article      id=\"_" + id + "\"\n  data-apage-opath=\"/" + article.path + "\"\n  data-apage-dname=\"_" + (dirname(article.path)) + "\"\n  data-apage-order=\"" + (ordername(article.path)) + "\"\n  data-apage-front='" + ((JSON.stringify(article.front)).replace(/'/g, "&#39;")) + "'\n  data-apage-title=\"" + article.title + "\"\n             class=\"apage\">");
      ref = article.html;
      for (k = 0, len1 = ref.length; k < len1; k++) {
        line = ref[k];
        out.push(filterLine(config, line));
      }
      out.push("</article><!-- #/" + id + " -->\n\n");
    }
    out.push('<!-- NB, Apage plugins may inject elements below this line -->');
    return out.join('\n  ') + '\n\n</body>\n</html>';
  };

  style = function(config) {
    return "/* normalize.css v3.0.3 | MIT License | github.com/necolas/normalize.css */\n\n    /* Document */\n    html { font-family:sans-serif; -ms-text-size-adjust:100%; -webkit-text-size-adjust:100% }\n    body { margin:0 }\n\n    /* HTML5 */\n    article,aside,details,figcaption,figure,footer,header,hgroup,main,menu,nav,\n    section,summary { display: block }\n    audio,canvas,progress,video { display:inline-block; vertical-align:baseline }\n    audio:not([controls]) { display:none; height:0 }\n    [hidden],template { display:none }\n\n    /* Links */\n    a { background-color:transparent }\n    a:active,a:hover { outline:0 }\n\n    /* Text */\n    abbr[title] { border-bottom: 1px dotted }\n    b, strong { font-weight: bold }\n    dfn { font-style: italic }\n    h1 { font-size: 2em; margin: 0.67em 0 }\n    mark { background: #ff0; color: #000 }\n    small { font-size: 80% }\n    sub,sup { font-size:75%; line-height:0; position:relative; vertical-align:baseline }\n    sup { top: -0.5em }\n    sub { bottom: -0.25em }\n\n    /* Embedded */\n    img { border: 0 }\n    svg:not(:root) { overflow: hidden }\n\n    /* Grouping */\n    figure { margin: 1em 40px }\n    hr { box-sizing: content-box; height: 0 }\n    pre { overflow: auto }\n    code,kbd,pre,samp { font-family:monospace,monospace; font-size:1em }\n\n    /* Forms */\n    button,input,optgroup,select,textarea { color:inherit; font:inherit; margin:0 }\n    button { overflow:visible }\n    button,select { text-transform:none }\n    button,html input[type=\"button\"],input[type=\"reset\"],\n    input[type=\"submit\"] { -webkit-appearance:button; cursor:pointer }\n    button[disabled],html input[disabled] { cursor:default }\n    button::-moz-focus-inner,input::-moz-focus-inner{ border:0; padding:0 }\n    input { line-height:normal }\n    input[type=\"checkbox\"],input[type=\"radio\"] { box-sizing:border-box; padding:0 }\n    input[type=\"number\"]::-webkit-inner-spin-button,\n    input[type=\"number\"]::-webkit-outer-spin-button { height:auto }\n    input[type=\"search\"] { -webkit-appearance:textfield; box-sizing:content-box }\n    input[type=\"search\"]::-webkit-search-cancel-button,\n    input[type=\"search\"]::-webkit-search-decoration { -webkit-appearance:none }\n    fieldset { border:1px solid #c0c0c0; margin:0 2px; padding:0.35em 0.625em 0.75em }\n    legend { border:0; padding:0 }\n    textarea { overflow:auto }\n    optgroup { font-weight:bold }\n\n    /* Tables */\n    table { border-collapse:collapse; border-spacing:0 }\n    td,th { padding:0 }\n\n\n    /* https://raw.githubusercontent.com/owenversteeg/min/gh-pages/compiled/general.css */\n    body,\n    textarea,\n    input,\n    select {\n      background: 0;\n      border-radius: 0;\n      font: 16px sans-serif;\n      margin: 0;\n    }\n    .addon,\n    .btn-sm,\n    .nav,\n    textarea,\n    input,\n    select {\n      outline: 0;\n      font-size: 14px;\n    }\n    .smooth {\n      transition: all .2s;\n    }\n    .btn,\n    .nav a {\n      text-decoration: none;\n    }\n    .container {\n      margin: 0 20px;\n      width: auto;\n    }\n    @media (min-width: 1310px) {\n      .container {\n        margin: auto;\n        width: 1270px;\n      }\n    }\n    .btn,\n    h2 {\n      font-size: 2em;\n    }\n\n\n    /* https://raw.githubusercontent.com/owenversteeg/min/gh-pages/compiled/navbar.css */\n    .nav,\n    .nav .current,\n    .nav a:hover {\n      background: #000;\n      color: #fff;\n    }\n    .nav {\n      height: 24px;\n      padding: 11px 0 15px;\n      /* TODO: migrate to ems (currently we don't use them because of iOS compatibility problems (has to do with unicode icon for close)) */\n      /* Uncomment for animations\n      max-height: 1.5em;\n      */\n    }\n    .nav a {\n      color: #aaa;\n      padding-right: 1em;\n      position: relative;\n      top: -1px;\n    }\n    .nav .pagename {\n      font-size: 22px;\n      top: 1px;\n    }\n    .btn.btn-close {\n      background: #000;\n      float: right;\n      font-size: 25px;\n      margin: -54px 7px;\n      display: none;\n    }\n    @media (max-width: 500px) {\n      .btn.btn-close {\n        display: block;\n      }\n      .nav {\n        /* transition: max-height .5s ease-in-out, height .5s ease-in-out; */\n        overflow: hidden;\n      }\n      .pagename {\n        margin-top: -11px;\n      }\n      .nav:active,\n      .nav:focus {\n        height: auto;\n        /* Necesary for animations\n        max-height: 500px;\n        height: 100%;\n        */\n      }\n      .nav div:before {\n        background: #000;\n        border-bottom: 10px double;\n        border-top: 3px solid;\n        content: '';\n        float: right;\n        height: 4px;\n        position: relative;\n        right: 3px;\n        top: 14px;\n        width: 20px;\n      }\n      .nav a {\n        display: block;\n        padding: .5em 0;\n        width: 50%;\n      }\n    }\n\n    /* Custom Apage: Navigation */\n    .nav .index  { text-transform:uppercase; }\n    .nav .active { color:#fff; }\n\n    /* Custom Apage: Definition List */\n    dl, dt, dd { display:inline-block; margin:0; color:#eee }\n    dl { margin-top: .5rem; padding:.5em 1em .4em; background: #333; border-radius:3px }\n    dt { text-transform:uppercase; font-size: .7rem; }\n    dt:after { content:\": \" }\n\n    p, ul, ol { line-height:1.4; }\n\n  /* NB, Apage plugins may inject CSS below this line */\n";
  };

  filterLine = function(config, line) {
    var rx;
    if (config.url) {
      rx = new RegExp('href="' + config.url, 'g');
      return line.replace(rx, 'href="');
    }
  };

  tidypath = function(p) {
    var name, order;
    name = filename(p).split('-');
    order = name[0];
    name = isNaN(order * 1) ? name.join('-') : name.slice(1).join('-');
    return dirname(p) + name.split('.').slice(0, -1).join('.');
  };

  dirname = function(p) {
    return ªhas(p, '/', p.split('/').slice(0, -1).join('_') + '_', '');
  };

  filename = function(p) {
    return p.split('/').slice(-1)[0];
  };

  ordername = function(p) {
    var order;
    order = filename(p).split('-')[0];
    if (isNaN(order * 1)) {
      return "'" + order + "'";
    } else {
      return order * 1;
    }
  };

  script = function(config, articles) {
    if (!config.plugin) {
      return '';
    }
    return "\n  <script>\n\n//// When the DOM is ready, set up Apage and inject the plugins. \nwindow.addEventListener('load', function () { (function (d) { 'use strict'; \n\n\n//// Declare iterator, length and HTML-reference variables. \nvar i, l, $ref\n\n\n//// Initialize two arrays which are available to all Apage plugins. \n ,arts      = []\n ,resolvers = []\n ,updaters  = []\n\n\n//// Like jQuery, but native. \n ,$  = d.querySelector.bind(d)\n ,$$ = d.querySelectorAll.bind(d)\n\n\n//// Gets a reference to all `<article class=\"apage\">` elements. \n ,$arts = $$('article.apage')\n\n\n//// Runs each resolver in order. These are added by the plugins, below. \n//// Resolvers are used to map a query to an article. \n ,resolve = function (query) {\n    for (var i=0, l=resolvers.length, backstop, result={}; i<l; i++) {\n      result = resolvers[i](query);\n      if (result.art) { break; } // `query` does resolve to an article\n      backstop = result.backstop || backstop; // may return a backstop\n    }\n    return result.art ? result.art : backstop; //@todo test logic of 'last valid backstop return' with several plugins at once\n  }\n\n\n//// Runs each updater in order. These are added by the plugins, below. \n//// Updaters change the current DOM state, eg to show a single article. \n ,update = function (query) {\n    for (var i=0, l=updaters.length, current=resolve(query); i<l; i++) {\n      updaters[i](current);\n    }\n  }\n\n\n//// Tidies the URL hash and runs `update()` when the URL hash changes. \n ,onHashchange = function (event) {\n    update( window.location.hash.substr(1).replace(/\\//g,'_') );\n    if (event) { event.preventDefault(); }\n  }\n\n;\n\n\n//// Populate the `arts` array using data from our `<ARTICLE>` elements. \nfor (i=0, l=$arts.length; i<l; i++) {\n  $ref = $arts[i];\n  arts.push({\n    id:    $ref.getAttribute('id')\n   ,opath: $ref.getAttribute('data-apage-opath')\n   ,dname: $ref.getAttribute('data-apage-dname')\n   ,order: $ref.getAttribute('data-apage-order')\n   ,front: JSON.parse( $ref.getAttribute('data-apage-front') )\n   ,title: $ref.getAttribute('data-apage-title')\n   ,$ref:  $ref\n  });\n}\n\n\n//// Begin injecting plugins. \n\n" + config.plugin + "\n\n//// End injecting plugins. \n\n\n//// Run each updater when the page loads, and when the URL hash changes. \nonHashchange();\nwindow.addEventListener('hashchange', onHashchange);\n\n\n}).call(this, document) });\n\n  </script>\n";
  };

  Tudor = (function() {
    var invisibles;

    Tudor.prototype.I = 'Tudor';

    Tudor.prototype.toString = function() {
      return "[object " + I + "]";
    };

    Tudor.prototype.jobs = [];

    function Tudor(opt) {
      if (opt == null) {
        opt = {};
      }
      this["do"] = bind(this["do"], this);
      switch (opt.format) {
        case 'html':
          this.header = '<a href="#end" id="top">\u2b07</a>';
          this.footer = '\n<a href="#top" id="end">\u2b06</a>';
          break;
        default:
          this.header = '\u2b07';
          this.footer = '\n\u2b06';
      }
    }

    Tudor.prototype["do"] = function() {
      var actual, double, expect, failed, j, job, len, md, name, passed, ref, result, runner, summary;
      md = [];
      passed = failed = 0;
      double = null;
      ref = this.jobs;
      for (j = 0, len = ref.length; j < len; j++) {
        job = ref[j];
        switch (ªtype(job)) {
          case ªF:
            double = job(double);
            break;
          case ªS:
            md.push(job);
            break;
          case ªA:
            runner = job[0], name = job[1], expect = job[2], actual = job[3];
            result = runner(expect, actual, double);
            if (!result) {
              md.push("\u2713 " + name + "  ");
              passed++;
            } else {
              md.push("\u2718 " + name + "  ");
              md.push("    " + result + "  ");
              failed++;
            }
        }
        summary = failed ? "  FAILED " + failed + "/" + (passed + failed) + " \u2718" : "  passed " + passed + "/" + (passed + failed) + " \u2714";
      }
      md.unshift(this.header + summary);
      md.push(this.footer + summary);
      return md.join('\n');
    };

    Tudor.prototype.page = function(text) {
      return this.jobs.push(("\n\n" + text + "\n=") + (new Array(text.length).join('=')));
    };

    Tudor.prototype.section = function(text) {
      return this.jobs.push(("\n\n" + text + "\n-") + (new Array(text.length).join('-')) + '\n');
    };

    Tudor.prototype.fail = function(result, delivery, expect, types) {
      if (types) {
        result = (invisibles(result)) + " (" + (ªtype(result)) + ")";
        expect = (invisibles(expect)) + " (" + (ªtype(expect)) + ")";
      }
      return (invisibles(result)) + "\n    ...was " + delivery + ", but expected...\n    " + (invisibles(expect));
    };

    invisibles = function(value) {
      return value != null ? value.toString().replace(/^\s+|\s+$/g, function(match) {
        return '\u00b7' + (new Array(match.length)).join('\u00b7');
      }) : void 0;
    };

    Tudor.prototype.custom = function(al, runner) {
      var i;
      i = 0;
      while (i < al.length) {
        if (ªF === ªtype(al[i])) {
          this.jobs.push(al[i]);
        } else {
          this.jobs.push([runner, al[i], al[++i], al[++i]]);
        }
        i++;
      }
      return this.jobs.push('- - -');
    };

    Tudor.prototype.throws = function(al) {
      return this.custom(al, (function(_this) {
        return function(expect, actual, double) {
          var e, error;
          error = false;
          try {
            actual(double);
          } catch (_error) {
            e = _error;
            error = e.message;
          }
          if (!error) {
            return "No exception thrown, expected...\n    " + expect;
          } else if (expect !== error) {
            return _this.fail(error, 'thrown', expect);
          }
        };
      })(this));
    };

    Tudor.prototype.equal = function(al) {
      return this.custom(al, (function(_this) {
        return function(expect, actual, double) {
          var e, error, result;
          error = false;
          try {
            result = actual(double);
          } catch (_error) {
            e = _error;
            error = e.message;
          }
          if (error) {
            return "Unexpected exception...\n    " + error;
          } else if (expect !== result) {
            return _this.fail(result, 'returned', expect, result + '' === expect + '');
          }
        };
      })(this));
    };

    Tudor.prototype.is = function(al) {
      return this.custom(al, (function(_this) {
        return function(expect, actual, double) {
          var e, error, result;
          error = false;
          try {
            result = actual(double);
          } catch (_error) {
            e = _error;
            error = e.message;
          }
          if (error) {
            return "Unexpected exception...\n    " + error;
          } else if (expect !== ªtype(result)) {
            return _this.fail("type " + (ªtype(result)), 'returned', "type " + expect);
          }
        };
      })(this));
    };

    return Tudor;

  })();

  tudor = new Tudor({
    format: ªO === typeof window ? 'html' : 'plain'
  });

  Main.runTest = tudor["do"];

  tudor.page("`Apage` Constructor Usage");

  tudor.section("No `config` Argument");

  tudor.is([
    "Class is a function", ªF, function() {
      return Main;
    }, function() {
      return new Main;
    }, "Instance is an object", ªO, function(mock) {
      return mock;
    }
  ]);

  tudor.equal([
    "`toString()` is '[object Apage]'", '[object Apage]', function(mock) {
      return '' + mock;
    }, "`config` is null", '[object Apage]', function() {
      return '' + new Main(null);
    }
  ]);

  tudor.section("Basic `config`");

  tudor.equal([
    "Set the title", '[object Apage]', function() {
      return '' + new Main({
        title: 'Café'
      });
    }
  ]);

  tudor.page("`Apage` Constructor Errors");

  tudor.section("Invalid `config` Argument");

  tudor.throws([
    "`config` is not an object", "Invalid `config`:\n  `candidate` is type 'number' not 'object'", function() {
      return new Main(1);
    }, "`config` is a `Date` object", "Invalid `config`:\n  `candidate` is type 'date' not 'object'", function() {
      return new Main(new Date);
    }, "`config` is a `String` object", "Invalid `config`:\n  `candidate` is type 'string' not 'object'", function() {
      return new Main(new String('yikes!'));
    }
  ]);

  tudor.section("Invalid `config.title`");

  tudor.throws([
    "A number", "Invalid `config`:\n  Field 'title' is type 'number' not 'string'", function() {
      return new Main({
        title: 0
      });
    }, "An empty string", "Invalid `config`:\n  Field 'title' fails /^[^\\x00-\\x1F]{1,24}$/", function() {
      return new Main({
        title: ''
      });
    }, "25 characters long", "Invalid `config`:\n  Field 'title' fails /^[^\\x00-\\x1F]{1,24}$/", function() {
      return new Main({
        title: '1234567890123456789012345'
      });
    }, "Contains a tab", "Invalid `config`:\n  Field 'title' fails /^[^\\x00-\\x1F]{1,24}$/", function() {
      return new Main({
        title: 'tab character: \t'
      });
    }
  ]);

  tudor.page("`apage.config()` Usage");

  tudor.section("No argument");

  tudor.is([
    function() {
      return new Main;
    }, "`config()` is a function", ªF, function(mock) {
      return mock.config;
    }, "Returns an object", ªO, function(mock) {
      return mock.config();
    }
  ]);

  tudor.equal([
    "Returned object contains expected defaults", '{"title":"Untitled","url":false,"plugin":""}', function(mock) {
      return JSON.stringify(mock.config());
    }, "Returns a new object each time", false, function(mock) {
      return mock.config() === mock.config();
    }
  ]);

  tudor.section("Retrieve a config value");

  tudor.equal([
    "Default `title` is 'Untitled'", 'Untitled', function(mock) {
      return mock.config('title');
    }, function() {
      return new Main({
        title: '外国語の学習と教授'
      });
    }, "After constructing with Japanese `title`", '外国語の学習と教授', function(mock) {
      return mock.config('title');
    }, "Key not recognized", void 0, function(mock) {
      return mock.config('unrecognized');
    }
  ]);

  tudor.section("Set a valid config value");

  tudor.equal([
    "Set a Chinese `title`, two arg syntax, returns `undefined`", void 0, function(mock) {
      return mock.config('title', '語文教學・语文教学');
    }, "Check that Chinese `title` has been set", '語文教學・语文教学', function(mock) {
      return mock.config('title');
    }, "Set a Greek `title`, object syntax, returns `undefined`", void 0, function(mock) {
      return mock.config({
        title: 'Γλωσσική Εκμὰθηση'
      });
    }, "Check that Greek `title` has been set", 'Γλωσσική Εκμὰθηση', function(mock) {
      return mock.config('title');
    }
  ]);

  tudor.section("Set an invalid config value");

  tudor.is([
    "Returns an array", ªA, function(mock) {
      return mock.config('title', '');
    }
  ]);

  tudor.equal([
    "The array has one element", 1, function(mock) {
      return (mock.config('title', '')).length;
    }, "The array element is an expected error message", "Field 'title' fails /^[^\\x00-\\x1F]{1,24}$/", function(mock) {
      return (mock.config('title', ''))[0];
    }
  ]);

  tudor.page("`apage.render()` Usage");

  tudor.section("No argument");

  tudor.is([
    function() {
      return new Main;
    }, "`render()` is a function", ªF, function(mock) {
      return mock.render;
    }, "Returns a string", ªS, function(mock) {
      return mock.render();
    }
  ]);

  tudor.equal([
    "Returned string is expected length", 5773, function(mock) {
      return mock.render().length;
    }, "Shorter `title` changes string length", 5767, function(mock) {
      mock.config('title', 'OK');
      return mock.render().length;
    }
  ]);

  tudor.page("`apage.append()` Usage");

  tudor.section("No argument");

  tudor.is([
    function() {
      return new Main;
    }, "`append()` is a function", ªF, function(mock) {
      return mock.append;
    }, "Returns an object", ªO, function(mock) {
      return mock.append();
    }
  ]);

  tudor.equal([
    "Returned object is the instance itself", true, function(mock) {
      return mock.append() === mock;
    }, "The `path` field is rendered to inline script", 5736, function(mock) {
      return mock.append({
        path: 'abcxyz'
      }).render().indexOf('abcxyz');
    }, "Default `html` field is rendered to inline script", 5841, function(mock) {
      return mock.render().indexOf('@todo');
    }
  ]);

  tudor.page("`apage.append()` Errors");

  tudor.section("Invalid `article` argument");

  tudor.throws([
    "`config` is a number", "Invalid `config`:\n  `candidate` is type 'number' not 'object'", function(mock) {
      return mock.append(456);
    }
  ]);

  tudor.section("Invalid `path` field");

  tudor.throws([
    "`path` is not set", "Invalid `config`:\n  Missing field 'path' is mandatory", function(mock) {
      return mock.append({});
    }, "`path` is a boolean", "Invalid `config`:\n  Field 'path' is type 'boolean' not 'string'", function(mock) {
      return mock.append({
        path: true
      });
    }, "`path` is an empty string", "Invalid `config`:\n  Field 'path' fails /^[-.\\/a-zA-Z0-9]{1,64}$/", function(mock) {
      return mock.append({
        path: ''
      });
    }, "`path` is too long", "Invalid `config`:\n  Field 'path' fails /^[-.\\/a-zA-Z0-9]{1,64}$/", function(mock) {
      return mock.append({
        path: (new Array(66)).join('-')
      });
    }, "`path` contains an invalid character", "Invalid `config`:\n  Field 'path' fails /^[-.\\/a-zA-Z0-9]{1,64}$/", function(mock) {
      return mock.append({
        path: 'a\\b'
      });
    }
  ]);

  tudor.section("Invalid `raw` field");

  tudor.throws([
    "`raw` is an object", "Invalid `config`:\n  Field 'raw' is type 'object' not 'string'", function(mock) {
      return mock.append({
        path: 'a',
        raw: {}
      });
    }, "`raw` is too long", "Invalid `config`:\n  Field 'raw' fails /^[^\\x00-\\x08\\x0E-\\x1F]{0,10000}$/", function(mock) {
      return mock.append({
        path: 'c',
        raw: (new Array(10002)).join('-')
      });
    }, "`raw` contains an invalid character", "Invalid `config`:\n  Field 'raw' fails /^[^\\x00-\\x08\\x0E-\\x1F]{0,10000}$/", function(mock) {
      return mock.append({
        path: 'd',
        raw: 'x\bz'
      });
    }
  ]);

}).call(this);
