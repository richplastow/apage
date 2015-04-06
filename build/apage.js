// Generated by CoffeeScript 1.9.1

/*! Apage 0.0.2 //// MIT licence //// apage.richplastow.com //// */

(function() {
  var A, B, E, F, I, Main, N, O, R, S, U, V, X, header, style, ª;

  I = 'Apage';

  V = '0.0.2';

  A = 'array';

  B = 'boolean';

  E = 'error';

  F = 'function';

  N = 'number';

  O = 'object';

  R = 'regexp';

  S = 'string';

  U = 'undefined';

  X = 'null';

  ª = console.log.bind(console);

  ª.type = function(x) {
    return {}.toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase();
  };

  ª.populate = function(candidate, subject, rules, updating) {
    var errors, i, j, key, len, len1, rule, test, type, use, value;
    if (O !== ª.type(candidate)) {
      return ["`candidate` is type '" + (ª.type(candidate)) + "' not 'object'"];
    }
    errors = [];
    for (i = 0, len = rules.length; i < len; i++) {
      rule = rules[i];
      key = rule[0], use = rule[1], type = rule[2], test = rule[3];
      value = candidate[key];
      if (void 0 === value) {
        if (updating || void 0 !== use) {
          continue;
        } else {
          errors.push("Missing key '" + key + "' is mandatory");
        }
      } else if (type !== ª.type(value)) {
        errors.push("Key '" + key + "' is type '" + (ª.type(value)) + "' not '" + type + "'");
      } else if (!test.test(value)) {
        errors.push("Key '" + key + "' fails " + ('' + test));
      }
    }
    if (errors.length) {
      return errors;
    }
    for (j = 0, len1 = rules.length; j < len1; j++) {
      rule = rules[j];
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

  ª.clone = function(subject, rules) {
    var i, key, len, out, rule;
    out = {};
    for (i = 0, len = rules.length; i < len; i++) {
      rule = rules[i];
      key = rule[0];
      out[key] = subject[key];
    }
    return out;
  };

  Main = (function() {
    Main.prototype.I = I;

    Main.prototype.toString = function() {
      return "[object " + this.I + "]";
    };

    Main.prototype._rules = {
      config: [['title', 'Untitled', 'string', /^[^\x00-\x1F]{1,24}$/]]
    };

    function Main(config) {
      var errors;
      if (config == null) {
        config = {};
      }
      this._c = {};
      if (errors = ª.populate(config, this._c, this._rules.config)) {
        throw new Error('Invalid `config`:\n  ' + errors.join('\n  '));
      }
    }

    Main.prototype.config = function(key, value) {
      var obj;
      switch (arguments.length) {
        case 0:
          return ª.clone(this._c, this._rules.config);
        case 1:
          switch (ª.type(key)) {
            case S:
              return this._c[key];
            case O:
              return ª.populate(key, this._c, this._rules.config, true);
          }
          break;
        case 2:
          obj = {};
          obj[key] = value;
          return this.config(obj);
      }
    };

    Main.prototype.render = function() {
      return header(this._c);
    };

    return Main;

  })();

  if (F === typeof define && define.amd) {
    define(function() {
      return Main;
    });
  } else if (O === typeof module && module && module.exports) {
    module.exports = Main;
  } else {
    this[I] = Main;
  }

  header = function(config) {
    return "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n  <title>" + config.title + "</title>\n  <meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\">\n  <style>\n    " + (style()) + "\n  </style>\n</head>\n<body>\n  <h1>" + config.title + "</h1>";
  };

  style = function() {
    return "/* normalize.css v3.0.3 | MIT License | github.com/necolas/normalize.css */\n\n    /* Document */\n    html { font-family:sans-serif; -ms-text-size-adjust:100%; -webkit-text-size-adjust:100% }\n    body { margin:0 }\n\n    /* HTML5 */\n    article,aside,details,figcaption,figure,footer,header,hgroup,main,menu,nav,\n    section,summary { display: block }\n    audio,canvas,progress,video { display:inline-block; vertical-align:baseline }\n    audio:not([controls]) { display:none; height:0 }\n    [hidden],template { display:none }\n\n    /* Links */\n    a { background-color:transparent }\n    a:active,a:hover { outline:0 }\n\n    /* Text */\n    abbr[title] { border-bottom: 1px dotted }\n    b, strong { font-weight: bold }\n    dfn { font-style: italic }\n    h1 { font-size: 2em; margin: 0.67em 0 }\n    mark { background: #ff0; color: #000 }\n    small { font-size: 80% }\n    sub,sup { font-size:75%; line-height:0; position:relative; vertical-align:baseline }\n    sup { top: -0.5em }\n    sub { bottom: -0.25em }\n\n    /* Embedded */\n    img { border: 0 }\n    svg:not(:root) { overflow: hidden }\n\n    /* Grouping */\n    figure { margin: 1em 40px }\n    hr { box-sizing: content-box; height: 0 }\n    pre { overflow: auto }\n    code,kbd,pre,samp { font-family:monospace,monospace; font-size:1em }\n\n    /* Forms */\n    button,input,optgroup,select,textarea { color:inherit; font:inherit; margin:0 }\n    button { overflow:visible }\n    button,select { text-transform:none }\n    button,html input[type=\"button\"],input[type=\"reset\"],\n    input[type=\"submit\"] { -webkit-appearance:button; cursor:pointer }\n    button[disabled],html input[disabled] { cursor:default }\n    button::-moz-focus-inner,input::-moz-focus-inner{ border:0; padding:0 }\n    input { line-height:normal }\n    input[type=\"checkbox\"],input[type=\"radio\"] { box-sizing:border-box; padding:0 }\n    input[type=\"number\"]::-webkit-inner-spin-button,\n    input[type=\"number\"]::-webkit-outer-spin-button { height:auto }\n    input[type=\"search\"] { -webkit-appearance:textfield; box-sizing:content-box }\n    input[type=\"search\"]::-webkit-search-cancel-button,\n    input[type=\"search\"]::-webkit-search-decoration { -webkit-appearance:none }\n    fieldset { border:1px solid #c0c0c0; margin:0 2px; padding:0.35em 0.625em 0.75em }\n    legend { border:0; padding:0 }\n    textarea { overflow:auto }\n    optgroup { font-weight:bold }\n\n    /* Tables */\n    table { border-collapse:collapse; border-spacing:0 }\n    td,th { padding:0 }\n";
  };

}).call(this);