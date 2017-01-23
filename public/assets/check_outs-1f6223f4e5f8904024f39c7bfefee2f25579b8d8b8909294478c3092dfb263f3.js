/*!
 * Select2 4.0.3
 * https://select2.github.io
 *
 * Released under the MIT license
 * https://github.com/select2/select2/blob/master/LICENSE.md
 */

(function (factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module.
    define(['jquery'], factory);
  } else if (typeof exports === 'object') {
    // Node/CommonJS
    factory(require('jquery'));
  } else {
    // Browser globals
    factory(jQuery);
  }
}(function (jQuery) {
  // This is needed so we can catch the AMD loader configuration and use it
  // The inner file should be wrapped (by `banner.start.js`) in a function that
  // returns the AMD loader references.
  var S2 =
(function () {
  // Restore the Select2 AMD loader so it can be used
  // Needed mostly in the language files, where the loader is not inserted
  if (jQuery && jQuery.fn && jQuery.fn.select2 && jQuery.fn.select2.amd) {
    var S2 = jQuery.fn.select2.amd;
  }
var S2;(function () { if (!S2 || !S2.requirejs) {
if (!S2) { S2 = {}; } else { require = S2; }
/**
 * @license almond 0.3.1 Copyright (c) 2011-2014, The Dojo Foundation All Rights Reserved.
 * Available via the MIT or new BSD license.
 * see: http://github.com/jrburke/almond for details
 */
//Going sloppy to avoid 'use strict' string cost, but strict practices should
//be followed.
/*jslint sloppy: true */
/*global setTimeout: false */

var requirejs, require, define;
(function (undef) {
    var main, req, makeMap, handlers,
        defined = {},
        waiting = {},
        config = {},
        defining = {},
        hasOwn = Object.prototype.hasOwnProperty,
        aps = [].slice,
        jsSuffixRegExp = /\.js$/;

    function hasProp(obj, prop) {
        return hasOwn.call(obj, prop);
    }

    /**
     * Given a relative module name, like ./something, normalize it to
     * a real name that can be mapped to a path.
     * @param {String} name the relative name
     * @param {String} baseName a real name that the name arg is relative
     * to.
     * @returns {String} normalized name
     */
    function normalize(name, baseName) {
        var nameParts, nameSegment, mapValue, foundMap, lastIndex,
            foundI, foundStarMap, starI, i, j, part,
            baseParts = baseName && baseName.split("/"),
            map = config.map,
            starMap = (map && map['*']) || {};

        //Adjust any relative paths.
        if (name && name.charAt(0) === ".") {
            //If have a base name, try to normalize against it,
            //otherwise, assume it is a top-level require that will
            //be relative to baseUrl in the end.
            if (baseName) {
                name = name.split('/');
                lastIndex = name.length - 1;

                // Node .js allowance:
                if (config.nodeIdCompat && jsSuffixRegExp.test(name[lastIndex])) {
                    name[lastIndex] = name[lastIndex].replace(jsSuffixRegExp, '');
                }

                //Lop off the last part of baseParts, so that . matches the
                //"directory" and not name of the baseName's module. For instance,
                //baseName of "one/two/three", maps to "one/two/three.js", but we
                //want the directory, "one/two" for this normalization.
                name = baseParts.slice(0, baseParts.length - 1).concat(name);

                //start trimDots
                for (i = 0; i < name.length; i += 1) {
                    part = name[i];
                    if (part === ".") {
                        name.splice(i, 1);
                        i -= 1;
                    } else if (part === "..") {
                        if (i === 1 && (name[2] === '..' || name[0] === '..')) {
                            //End of the line. Keep at least one non-dot
                            //path segment at the front so it can be mapped
                            //correctly to disk. Otherwise, there is likely
                            //no path mapping for a path starting with '..'.
                            //This can still fail, but catches the most reasonable
                            //uses of ..
                            break;
                        } else if (i > 0) {
                            name.splice(i - 1, 2);
                            i -= 2;
                        }
                    }
                }
                //end trimDots

                name = name.join("/");
            } else if (name.indexOf('./') === 0) {
                // No baseName, so this is ID is resolved relative
                // to baseUrl, pull off the leading dot.
                name = name.substring(2);
            }
        }

        //Apply map config if available.
        if ((baseParts || starMap) && map) {
            nameParts = name.split('/');

            for (i = nameParts.length; i > 0; i -= 1) {
                nameSegment = nameParts.slice(0, i).join("/");

                if (baseParts) {
                    //Find the longest baseName segment match in the config.
                    //So, do joins on the biggest to smallest lengths of baseParts.
                    for (j = baseParts.length; j > 0; j -= 1) {
                        mapValue = map[baseParts.slice(0, j).join('/')];

                        //baseName segment has  config, find if it has one for
                        //this name.
                        if (mapValue) {
                            mapValue = mapValue[nameSegment];
                            if (mapValue) {
                                //Match, update name to the new value.
                                foundMap = mapValue;
                                foundI = i;
                                break;
                            }
                        }
                    }
                }

                if (foundMap) {
                    break;
                }

                //Check for a star map match, but just hold on to it,
                //if there is a shorter segment match later in a matching
                //config, then favor over this star map.
                if (!foundStarMap && starMap && starMap[nameSegment]) {
                    foundStarMap = starMap[nameSegment];
                    starI = i;
                }
            }

            if (!foundMap && foundStarMap) {
                foundMap = foundStarMap;
                foundI = starI;
            }

            if (foundMap) {
                nameParts.splice(0, foundI, foundMap);
                name = nameParts.join('/');
            }
        }

        return name;
    }

    function makeRequire(relName, forceSync) {
        return function () {
            //A version of a require function that passes a moduleName
            //value for items that may need to
            //look up paths relative to the moduleName
            var args = aps.call(arguments, 0);

            //If first arg is not require('string'), and there is only
            //one arg, it is the array form without a callback. Insert
            //a null so that the following concat is correct.
            if (typeof args[0] !== 'string' && args.length === 1) {
                args.push(null);
            }
            return req.apply(undef, args.concat([relName, forceSync]));
        };
    }

    function makeNormalize(relName) {
        return function (name) {
            return normalize(name, relName);
        };
    }

    function makeLoad(depName) {
        return function (value) {
            defined[depName] = value;
        };
    }

    function callDep(name) {
        if (hasProp(waiting, name)) {
            var args = waiting[name];
            delete waiting[name];
            defining[name] = true;
            main.apply(undef, args);
        }

        if (!hasProp(defined, name) && !hasProp(defining, name)) {
            throw new Error('No ' + name);
        }
        return defined[name];
    }

    //Turns a plugin!resource to [plugin, resource]
    //with the plugin being undefined if the name
    //did not have a plugin prefix.
    function splitPrefix(name) {
        var prefix,
            index = name ? name.indexOf('!') : -1;
        if (index > -1) {
            prefix = name.substring(0, index);
            name = name.substring(index + 1, name.length);
        }
        return [prefix, name];
    }

    /**
     * Makes a name map, normalizing the name, and using a plugin
     * for normalization if necessary. Grabs a ref to plugin
     * too, as an optimization.
     */
    makeMap = function (name, relName) {
        var plugin,
            parts = splitPrefix(name),
            prefix = parts[0];

        name = parts[1];

        if (prefix) {
            prefix = normalize(prefix, relName);
            plugin = callDep(prefix);
        }

        //Normalize according
        if (prefix) {
            if (plugin && plugin.normalize) {
                name = plugin.normalize(name, makeNormalize(relName));
            } else {
                name = normalize(name, relName);
            }
        } else {
            name = normalize(name, relName);
            parts = splitPrefix(name);
            prefix = parts[0];
            name = parts[1];
            if (prefix) {
                plugin = callDep(prefix);
            }
        }

        //Using ridiculous property names for space reasons
        return {
            f: prefix ? prefix + '!' + name : name, //fullName
            n: name,
            pr: prefix,
            p: plugin
        };
    };

    function makeConfig(name) {
        return function () {
            return (config && config.config && config.config[name]) || {};
        };
    }

    handlers = {
        require: function (name) {
            return makeRequire(name);
        },
        exports: function (name) {
            var e = defined[name];
            if (typeof e !== 'undefined') {
                return e;
            } else {
                return (defined[name] = {});
            }
        },
        module: function (name) {
            return {
                id: name,
                uri: '',
                exports: defined[name],
                config: makeConfig(name)
            };
        }
    };

    main = function (name, deps, callback, relName) {
        var cjsModule, depName, ret, map, i,
            args = [],
            callbackType = typeof callback,
            usingExports;

        //Use name if no relName
        relName = relName || name;

        //Call the callback to define the module, if necessary.
        if (callbackType === 'undefined' || callbackType === 'function') {
            //Pull out the defined dependencies and pass the ordered
            //values to the callback.
            //Default to [require, exports, module] if no deps
            deps = !deps.length && callback.length ? ['require', 'exports', 'module'] : deps;
            for (i = 0; i < deps.length; i += 1) {
                map = makeMap(deps[i], relName);
                depName = map.f;

                //Fast path CommonJS standard dependencies.
                if (depName === "require") {
                    args[i] = handlers.require(name);
                } else if (depName === "exports") {
                    //CommonJS module spec 1.1
                    args[i] = handlers.exports(name);
                    usingExports = true;
                } else if (depName === "module") {
                    //CommonJS module spec 1.1
                    cjsModule = args[i] = handlers.module(name);
                } else if (hasProp(defined, depName) ||
                           hasProp(waiting, depName) ||
                           hasProp(defining, depName)) {
                    args[i] = callDep(depName);
                } else if (map.p) {
                    map.p.load(map.n, makeRequire(relName, true), makeLoad(depName), {});
                    args[i] = defined[depName];
                } else {
                    throw new Error(name + ' missing ' + depName);
                }
            }

            ret = callback ? callback.apply(defined[name], args) : undefined;

            if (name) {
                //If setting exports via "module" is in play,
                //favor that over return value and exports. After that,
                //favor a non-undefined return value over exports use.
                if (cjsModule && cjsModule.exports !== undef &&
                        cjsModule.exports !== defined[name]) {
                    defined[name] = cjsModule.exports;
                } else if (ret !== undef || !usingExports) {
                    //Use the return value from the function.
                    defined[name] = ret;
                }
            }
        } else if (name) {
            //May just be an object definition for the module. Only
            //worry about defining if have a module name.
            defined[name] = callback;
        }
    };

    requirejs = require = req = function (deps, callback, relName, forceSync, alt) {
        if (typeof deps === "string") {
            if (handlers[deps]) {
                //callback in this case is really relName
                return handlers[deps](callback);
            }
            //Just return the module wanted. In this scenario, the
            //deps arg is the module name, and second arg (if passed)
            //is just the relName.
            //Normalize module name, if it contains . or ..
            return callDep(makeMap(deps, callback).f);
        } else if (!deps.splice) {
            //deps is a config object, not an array.
            config = deps;
            if (config.deps) {
                req(config.deps, config.callback);
            }
            if (!callback) {
                return;
            }

            if (callback.splice) {
                //callback is an array, which means it is a dependency list.
                //Adjust args if there are dependencies
                deps = callback;
                callback = relName;
                relName = null;
            } else {
                deps = undef;
            }
        }

        //Support require(['a'])
        callback = callback || function () {};

        //If relName is a function, it is an errback handler,
        //so remove it.
        if (typeof relName === 'function') {
            relName = forceSync;
            forceSync = alt;
        }

        //Simulate async callback;
        if (forceSync) {
            main(undef, deps, callback, relName);
        } else {
            //Using a non-zero value because of concern for what old browsers
            //do, and latest browsers "upgrade" to 4 if lower value is used:
            //http://www.whatwg.org/specs/web-apps/current-work/multipage/timers.html#dom-windowtimers-settimeout:
            //If want a value immediately, use require('id') instead -- something
            //that works in almond on the global level, but not guaranteed and
            //unlikely to work in other AMD implementations.
            setTimeout(function () {
                main(undef, deps, callback, relName);
            }, 4);
        }

        return req;
    };

    /**
     * Just drops the config on the floor, but returns req in case
     * the config return value is used.
     */
    req.config = function (cfg) {
        return req(cfg);
    };

    /**
     * Expose module registry for debugging and tooling
     */
    requirejs._defined = defined;

    define = function (name, deps, callback) {
        if (typeof name !== 'string') {
            throw new Error('See almond README: incorrect module build, no module name');
        }

        //This module may not have dependencies
        if (!deps.splice) {
            //deps is not an array, so probably means
            //an object literal or factory function for
            //the value. Adjust args.
            callback = deps;
            deps = [];
        }

        if (!hasProp(defined, name) && !hasProp(waiting, name)) {
            waiting[name] = [name, deps, callback];
        }
    };

    define.amd = {
        jQuery: true
    };
}());

S2.requirejs = requirejs;S2.require = require;S2.define = define;
}
}());
S2.define("almond", function(){});

/* global jQuery:false, $:false */
S2.define('jquery',[],function () {
  var _$ = jQuery || $;

  if (_$ == null && console && console.error) {
    console.error(
      'Select2: An instance of jQuery or a jQuery-compatible library was not ' +
      'found. Make sure that you are including jQuery before Select2 on your ' +
      'web page.'
    );
  }

  return _$;
});

S2.define('select2/utils',[
  'jquery'
], function ($) {
  var Utils = {};

  Utils.Extend = function (ChildClass, SuperClass) {
    var __hasProp = {}.hasOwnProperty;

    function BaseConstructor () {
      this.constructor = ChildClass;
    }

    for (var key in SuperClass) {
      if (__hasProp.call(SuperClass, key)) {
        ChildClass[key] = SuperClass[key];
      }
    }

    BaseConstructor.prototype = SuperClass.prototype;
    ChildClass.prototype = new BaseConstructor();
    ChildClass.__super__ = SuperClass.prototype;

    return ChildClass;
  };

  function getMethods (theClass) {
    var proto = theClass.prototype;

    var methods = [];

    for (var methodName in proto) {
      var m = proto[methodName];

      if (typeof m !== 'function') {
        continue;
      }

      if (methodName === 'constructor') {
        continue;
      }

      methods.push(methodName);
    }

    return methods;
  }

  Utils.Decorate = function (SuperClass, DecoratorClass) {
    var decoratedMethods = getMethods(DecoratorClass);
    var superMethods = getMethods(SuperClass);

    function DecoratedClass () {
      var unshift = Array.prototype.unshift;

      var argCount = DecoratorClass.prototype.constructor.length;

      var calledConstructor = SuperClass.prototype.constructor;

      if (argCount > 0) {
        unshift.call(arguments, SuperClass.prototype.constructor);

        calledConstructor = DecoratorClass.prototype.constructor;
      }

      calledConstructor.apply(this, arguments);
    }

    DecoratorClass.displayName = SuperClass.displayName;

    function ctr () {
      this.constructor = DecoratedClass;
    }

    DecoratedClass.prototype = new ctr();

    for (var m = 0; m < superMethods.length; m++) {
        var superMethod = superMethods[m];

        DecoratedClass.prototype[superMethod] =
          SuperClass.prototype[superMethod];
    }

    var calledMethod = function (methodName) {
      // Stub out the original method if it's not decorating an actual method
      var originalMethod = function () {};

      if (methodName in DecoratedClass.prototype) {
        originalMethod = DecoratedClass.prototype[methodName];
      }

      var decoratedMethod = DecoratorClass.prototype[methodName];

      return function () {
        var unshift = Array.prototype.unshift;

        unshift.call(arguments, originalMethod);

        return decoratedMethod.apply(this, arguments);
      };
    };

    for (var d = 0; d < decoratedMethods.length; d++) {
      var decoratedMethod = decoratedMethods[d];

      DecoratedClass.prototype[decoratedMethod] = calledMethod(decoratedMethod);
    }

    return DecoratedClass;
  };

  var Observable = function () {
    this.listeners = {};
  };

  Observable.prototype.on = function (event, callback) {
    this.listeners = this.listeners || {};

    if (event in this.listeners) {
      this.listeners[event].push(callback);
    } else {
      this.listeners[event] = [callback];
    }
  };

  Observable.prototype.trigger = function (event) {
    var slice = Array.prototype.slice;
    var params = slice.call(arguments, 1);

    this.listeners = this.listeners || {};

    // Params should always come in as an array
    if (params == null) {
      params = [];
    }

    // If there are no arguments to the event, use a temporary object
    if (params.length === 0) {
      params.push({});
    }

    // Set the `_type` of the first object to the event
    params[0]._type = event;

    if (event in this.listeners) {
      this.invoke(this.listeners[event], slice.call(arguments, 1));
    }

    if ('*' in this.listeners) {
      this.invoke(this.listeners['*'], arguments);
    }
  };

  Observable.prototype.invoke = function (listeners, params) {
    for (var i = 0, len = listeners.length; i < len; i++) {
      listeners[i].apply(this, params);
    }
  };

  Utils.Observable = Observable;

  Utils.generateChars = function (length) {
    var chars = '';

    for (var i = 0; i < length; i++) {
      var randomChar = Math.floor(Math.random() * 36);
      chars += randomChar.toString(36);
    }

    return chars;
  };

  Utils.bind = function (func, context) {
    return function () {
      func.apply(context, arguments);
    };
  };

  Utils._convertData = function (data) {
    for (var originalKey in data) {
      var keys = originalKey.split('-');

      var dataLevel = data;

      if (keys.length === 1) {
        continue;
      }

      for (var k = 0; k < keys.length; k++) {
        var key = keys[k];

        // Lowercase the first letter
        // By default, dash-separated becomes camelCase
        key = key.substring(0, 1).toLowerCase() + key.substring(1);

        if (!(key in dataLevel)) {
          dataLevel[key] = {};
        }

        if (k == keys.length - 1) {
          dataLevel[key] = data[originalKey];
        }

        dataLevel = dataLevel[key];
      }

      delete data[originalKey];
    }

    return data;
  };

  Utils.hasScroll = function (index, el) {
    // Adapted from the function created by @ShadowScripter
    // and adapted by @BillBarry on the Stack Exchange Code Review website.
    // The original code can be found at
    // http://codereview.stackexchange.com/q/13338
    // and was designed to be used with the Sizzle selector engine.

    var $el = $(el);
    var overflowX = el.style.overflowX;
    var overflowY = el.style.overflowY;

    //Check both x and y declarations
    if (overflowX === overflowY &&
        (overflowY === 'hidden' || overflowY === 'visible')) {
      return false;
    }

    if (overflowX === 'scroll' || overflowY === 'scroll') {
      return true;
    }

    return ($el.innerHeight() < el.scrollHeight ||
      $el.innerWidth() < el.scrollWidth);
  };

  Utils.escapeMarkup = function (markup) {
    var replaceMap = {
      '\\': '&#92;',
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      '\'': '&#39;',
      '/': '&#47;'
    };

    // Do not try to escape the markup if it's not a string
    if (typeof markup !== 'string') {
      return markup;
    }

    return String(markup).replace(/[&<>"'\/\\]/g, function (match) {
      return replaceMap[match];
    });
  };

  // Append an array of jQuery nodes to a given element.
  Utils.appendMany = function ($element, $nodes) {
    // jQuery 1.7.x does not support $.fn.append() with an array
    // Fall back to a jQuery object collection using $.fn.add()
    if ($.fn.jquery.substr(0, 3) === '1.7') {
      var $jqNodes = $();

      $.map($nodes, function (node) {
        $jqNodes = $jqNodes.add(node);
      });

      $nodes = $jqNodes;
    }

    $element.append($nodes);
  };

  return Utils;
});

S2.define('select2/results',[
  'jquery',
  './utils'
], function ($, Utils) {
  function Results ($element, options, dataAdapter) {
    this.$element = $element;
    this.data = dataAdapter;
    this.options = options;

    Results.__super__.constructor.call(this);
  }

  Utils.Extend(Results, Utils.Observable);

  Results.prototype.render = function () {
    var $results = $(
      '<ul class="select2-results__options" role="tree"></ul>'
    );

    if (this.options.get('multiple')) {
      $results.attr('aria-multiselectable', 'true');
    }

    this.$results = $results;

    return $results;
  };

  Results.prototype.clear = function () {
    this.$results.empty();
  };

  Results.prototype.displayMessage = function (params) {
    var escapeMarkup = this.options.get('escapeMarkup');

    this.clear();
    this.hideLoading();

    var $message = $(
      '<li role="treeitem" aria-live="assertive"' +
      ' class="select2-results__option"></li>'
    );

    var message = this.options.get('translations').get(params.message);

    $message.append(
      escapeMarkup(
        message(params.args)
      )
    );

    $message[0].className += ' select2-results__message';

    this.$results.append($message);
  };

  Results.prototype.hideMessages = function () {
    this.$results.find('.select2-results__message').remove();
  };

  Results.prototype.append = function (data) {
    this.hideLoading();

    var $options = [];

    if (data.results == null || data.results.length === 0) {
      if (this.$results.children().length === 0) {
        this.trigger('results:message', {
          message: 'noResults'
        });
      }

      return;
    }

    data.results = this.sort(data.results);

    for (var d = 0; d < data.results.length; d++) {
      var item = data.results[d];

      var $option = this.option(item);

      $options.push($option);
    }

    this.$results.append($options);
  };

  Results.prototype.position = function ($results, $dropdown) {
    var $resultsContainer = $dropdown.find('.select2-results');
    $resultsContainer.append($results);
  };

  Results.prototype.sort = function (data) {
    var sorter = this.options.get('sorter');

    return sorter(data);
  };

  Results.prototype.highlightFirstItem = function () {
    var $options = this.$results
      .find('.select2-results__option[aria-selected]');

    var $selected = $options.filter('[aria-selected=true]');

    // Check if there are any selected options
    if ($selected.length > 0) {
      // If there are selected options, highlight the first
      $selected.first().trigger('mouseenter');
    } else {
      // If there are no selected options, highlight the first option
      // in the dropdown
      $options.first().trigger('mouseenter');
    }

    this.ensureHighlightVisible();
  };

  Results.prototype.setClasses = function () {
    var self = this;

    this.data.current(function (selected) {
      var selectedIds = $.map(selected, function (s) {
        return s.id.toString();
      });

      var $options = self.$results
        .find('.select2-results__option[aria-selected]');

      $options.each(function () {
        var $option = $(this);

        var item = $.data(this, 'data');

        // id needs to be converted to a string when comparing
        var id = '' + item.id;

        if ((item.element != null && item.element.selected) ||
            (item.element == null && $.inArray(id, selectedIds) > -1)) {
          $option.attr('aria-selected', 'true');
        } else {
          $option.attr('aria-selected', 'false');
        }
      });

    });
  };

  Results.prototype.showLoading = function (params) {
    this.hideLoading();

    var loadingMore = this.options.get('translations').get('searching');

    var loading = {
      disabled: true,
      loading: true,
      text: loadingMore(params)
    };
    var $loading = this.option(loading);
    $loading.className += ' loading-results';

    this.$results.prepend($loading);
  };

  Results.prototype.hideLoading = function () {
    this.$results.find('.loading-results').remove();
  };

  Results.prototype.option = function (data) {
    var option = document.createElement('li');
    option.className = 'select2-results__option';

    var attrs = {
      'role': 'treeitem',
      'aria-selected': 'false'
    };

    if (data.disabled) {
      delete attrs['aria-selected'];
      attrs['aria-disabled'] = 'true';
    }

    if (data.id == null) {
      delete attrs['aria-selected'];
    }

    if (data._resultId != null) {
      option.id = data._resultId;
    }

    if (data.title) {
      option.title = data.title;
    }

    if (data.children) {
      attrs.role = 'group';
      attrs['aria-label'] = data.text;
      delete attrs['aria-selected'];
    }

    for (var attr in attrs) {
      var val = attrs[attr];

      option.setAttribute(attr, val);
    }

    if (data.children) {
      var $option = $(option);

      var label = document.createElement('strong');
      label.className = 'select2-results__group';

      var $label = $(label);
      this.template(data, label);

      var $children = [];

      for (var c = 0; c < data.children.length; c++) {
        var child = data.children[c];

        var $child = this.option(child);

        $children.push($child);
      }

      var $childrenContainer = $('<ul></ul>', {
        'class': 'select2-results__options select2-results__options--nested'
      });

      $childrenContainer.append($children);

      $option.append(label);
      $option.append($childrenContainer);
    } else {
      this.template(data, option);
    }

    $.data(option, 'data', data);

    return option;
  };

  Results.prototype.bind = function (container, $container) {
    var self = this;

    var id = container.id + '-results';

    this.$results.attr('id', id);

    container.on('results:all', function (params) {
      self.clear();
      self.append(params.data);

      if (container.isOpen()) {
        self.setClasses();
        self.highlightFirstItem();
      }
    });

    container.on('results:append', function (params) {
      self.append(params.data);

      if (container.isOpen()) {
        self.setClasses();
      }
    });

    container.on('query', function (params) {
      self.hideMessages();
      self.showLoading(params);
    });

    container.on('select', function () {
      if (!container.isOpen()) {
        return;
      }

      self.setClasses();
      self.highlightFirstItem();
    });

    container.on('unselect', function () {
      if (!container.isOpen()) {
        return;
      }

      self.setClasses();
      self.highlightFirstItem();
    });

    container.on('open', function () {
      // When the dropdown is open, aria-expended="true"
      self.$results.attr('aria-expanded', 'true');
      self.$results.attr('aria-hidden', 'false');

      self.setClasses();
      self.ensureHighlightVisible();
    });

    container.on('close', function () {
      // When the dropdown is closed, aria-expended="false"
      self.$results.attr('aria-expanded', 'false');
      self.$results.attr('aria-hidden', 'true');
      self.$results.removeAttr('aria-activedescendant');
    });

    container.on('results:toggle', function () {
      var $highlighted = self.getHighlightedResults();

      if ($highlighted.length === 0) {
        return;
      }

      $highlighted.trigger('mouseup');
    });

    container.on('results:select', function () {
      var $highlighted = self.getHighlightedResults();

      if ($highlighted.length === 0) {
        return;
      }

      var data = $highlighted.data('data');

      if ($highlighted.attr('aria-selected') == 'true') {
        self.trigger('close', {});
      } else {
        self.trigger('select', {
          data: data
        });
      }
    });

    container.on('results:previous', function () {
      var $highlighted = self.getHighlightedResults();

      var $options = self.$results.find('[aria-selected]');

      var currentIndex = $options.index($highlighted);

      // If we are already at te top, don't move further
      if (currentIndex === 0) {
        return;
      }

      var nextIndex = currentIndex - 1;

      // If none are highlighted, highlight the first
      if ($highlighted.length === 0) {
        nextIndex = 0;
      }

      var $next = $options.eq(nextIndex);

      $next.trigger('mouseenter');

      var currentOffset = self.$results.offset().top;
      var nextTop = $next.offset().top;
      var nextOffset = self.$results.scrollTop() + (nextTop - currentOffset);

      if (nextIndex === 0) {
        self.$results.scrollTop(0);
      } else if (nextTop - currentOffset < 0) {
        self.$results.scrollTop(nextOffset);
      }
    });

    container.on('results:next', function () {
      var $highlighted = self.getHighlightedResults();

      var $options = self.$results.find('[aria-selected]');

      var currentIndex = $options.index($highlighted);

      var nextIndex = currentIndex + 1;

      // If we are at the last option, stay there
      if (nextIndex >= $options.length) {
        return;
      }

      var $next = $options.eq(nextIndex);

      $next.trigger('mouseenter');

      var currentOffset = self.$results.offset().top +
        self.$results.outerHeight(false);
      var nextBottom = $next.offset().top + $next.outerHeight(false);
      var nextOffset = self.$results.scrollTop() + nextBottom - currentOffset;

      if (nextIndex === 0) {
        self.$results.scrollTop(0);
      } else if (nextBottom > currentOffset) {
        self.$results.scrollTop(nextOffset);
      }
    });

    container.on('results:focus', function (params) {
      params.element.addClass('select2-results__option--highlighted');
    });

    container.on('results:message', function (params) {
      self.displayMessage(params);
    });

    if ($.fn.mousewheel) {
      this.$results.on('mousewheel', function (e) {
        var top = self.$results.scrollTop();

        var bottom = self.$results.get(0).scrollHeight - top + e.deltaY;

        var isAtTop = e.deltaY > 0 && top - e.deltaY <= 0;
        var isAtBottom = e.deltaY < 0 && bottom <= self.$results.height();

        if (isAtTop) {
          self.$results.scrollTop(0);

          e.preventDefault();
          e.stopPropagation();
        } else if (isAtBottom) {
          self.$results.scrollTop(
            self.$results.get(0).scrollHeight - self.$results.height()
          );

          e.preventDefault();
          e.stopPropagation();
        }
      });
    }

    this.$results.on('mouseup', '.select2-results__option[aria-selected]',
      function (evt) {
      var $this = $(this);

      var data = $this.data('data');

      if ($this.attr('aria-selected') === 'true') {
        if (self.options.get('multiple')) {
          self.trigger('unselect', {
            originalEvent: evt,
            data: data
          });
        } else {
          self.trigger('close', {});
        }

        return;
      }

      self.trigger('select', {
        originalEvent: evt,
        data: data
      });
    });

    this.$results.on('mouseenter', '.select2-results__option[aria-selected]',
      function (evt) {
      var data = $(this).data('data');

      self.getHighlightedResults()
          .removeClass('select2-results__option--highlighted');

      self.trigger('results:focus', {
        data: data,
        element: $(this)
      });
    });
  };

  Results.prototype.getHighlightedResults = function () {
    var $highlighted = this.$results
    .find('.select2-results__option--highlighted');

    return $highlighted;
  };

  Results.prototype.destroy = function () {
    this.$results.remove();
  };

  Results.prototype.ensureHighlightVisible = function () {
    var $highlighted = this.getHighlightedResults();

    if ($highlighted.length === 0) {
      return;
    }

    var $options = this.$results.find('[aria-selected]');

    var currentIndex = $options.index($highlighted);

    var currentOffset = this.$results.offset().top;
    var nextTop = $highlighted.offset().top;
    var nextOffset = this.$results.scrollTop() + (nextTop - currentOffset);

    var offsetDelta = nextTop - currentOffset;
    nextOffset -= $highlighted.outerHeight(false) * 2;

    if (currentIndex <= 2) {
      this.$results.scrollTop(0);
    } else if (offsetDelta > this.$results.outerHeight() || offsetDelta < 0) {
      this.$results.scrollTop(nextOffset);
    }
  };

  Results.prototype.template = function (result, container) {
    var template = this.options.get('templateResult');
    var escapeMarkup = this.options.get('escapeMarkup');

    var content = template(result, container);

    if (content == null) {
      container.style.display = 'none';
    } else if (typeof content === 'string') {
      container.innerHTML = escapeMarkup(content);
    } else {
      $(container).append(content);
    }
  };

  return Results;
});

S2.define('select2/keys',[

], function () {
  var KEYS = {
    BACKSPACE: 8,
    TAB: 9,
    ENTER: 13,
    SHIFT: 16,
    CTRL: 17,
    ALT: 18,
    ESC: 27,
    SPACE: 32,
    PAGE_UP: 33,
    PAGE_DOWN: 34,
    END: 35,
    HOME: 36,
    LEFT: 37,
    UP: 38,
    RIGHT: 39,
    DOWN: 40,
    DELETE: 46
  };

  return KEYS;
});

S2.define('select2/selection/base',[
  'jquery',
  '../utils',
  '../keys'
], function ($, Utils, KEYS) {
  function BaseSelection ($element, options) {
    this.$element = $element;
    this.options = options;

    BaseSelection.__super__.constructor.call(this);
  }

  Utils.Extend(BaseSelection, Utils.Observable);

  BaseSelection.prototype.render = function () {
    var $selection = $(
      '<span class="select2-selection" role="combobox" ' +
      ' aria-haspopup="true" aria-expanded="false">' +
      '</span>'
    );

    this._tabindex = 0;

    if (this.$element.data('old-tabindex') != null) {
      this._tabindex = this.$element.data('old-tabindex');
    } else if (this.$element.attr('tabindex') != null) {
      this._tabindex = this.$element.attr('tabindex');
    }

    $selection.attr('title', this.$element.attr('title'));
    $selection.attr('tabindex', this._tabindex);

    this.$selection = $selection;

    return $selection;
  };

  BaseSelection.prototype.bind = function (container, $container) {
    var self = this;

    var id = container.id + '-container';
    var resultsId = container.id + '-results';

    this.container = container;

    this.$selection.on('focus', function (evt) {
      self.trigger('focus', evt);
    });

    this.$selection.on('blur', function (evt) {
      self._handleBlur(evt);
    });

    this.$selection.on('keydown', function (evt) {
      self.trigger('keypress', evt);

      if (evt.which === KEYS.SPACE) {
        evt.preventDefault();
      }
    });

    container.on('results:focus', function (params) {
      self.$selection.attr('aria-activedescendant', params.data._resultId);
    });

    container.on('selection:update', function (params) {
      self.update(params.data);
    });

    container.on('open', function () {
      // When the dropdown is open, aria-expanded="true"
      self.$selection.attr('aria-expanded', 'true');
      self.$selection.attr('aria-owns', resultsId);

      self._attachCloseHandler(container);
    });

    container.on('close', function () {
      // When the dropdown is closed, aria-expanded="false"
      self.$selection.attr('aria-expanded', 'false');
      self.$selection.removeAttr('aria-activedescendant');
      self.$selection.removeAttr('aria-owns');

      self.$selection.focus();

      self._detachCloseHandler(container);
    });

    container.on('enable', function () {
      self.$selection.attr('tabindex', self._tabindex);
    });

    container.on('disable', function () {
      self.$selection.attr('tabindex', '-1');
    });
  };

  BaseSelection.prototype._handleBlur = function (evt) {
    var self = this;

    // This needs to be delayed as the active element is the body when the tab
    // key is pressed, possibly along with others.
    window.setTimeout(function () {
      // Don't trigger `blur` if the focus is still in the selection
      if (
        (document.activeElement == self.$selection[0]) ||
        ($.contains(self.$selection[0], document.activeElement))
      ) {
        return;
      }

      self.trigger('blur', evt);
    }, 1);
  };

  BaseSelection.prototype._attachCloseHandler = function (container) {
    var self = this;

    $(document.body).on('mousedown.select2.' + container.id, function (e) {
      var $target = $(e.target);

      var $select = $target.closest('.select2');

      var $all = $('.select2.select2-container--open');

      $all.each(function () {
        var $this = $(this);

        if (this == $select[0]) {
          return;
        }

        var $element = $this.data('element');

        $element.select2('close');
      });
    });
  };

  BaseSelection.prototype._detachCloseHandler = function (container) {
    $(document.body).off('mousedown.select2.' + container.id);
  };

  BaseSelection.prototype.position = function ($selection, $container) {
    var $selectionContainer = $container.find('.selection');
    $selectionContainer.append($selection);
  };

  BaseSelection.prototype.destroy = function () {
    this._detachCloseHandler(this.container);
  };

  BaseSelection.prototype.update = function (data) {
    throw new Error('The `update` method must be defined in child classes.');
  };

  return BaseSelection;
});

S2.define('select2/selection/single',[
  'jquery',
  './base',
  '../utils',
  '../keys'
], function ($, BaseSelection, Utils, KEYS) {
  function SingleSelection () {
    SingleSelection.__super__.constructor.apply(this, arguments);
  }

  Utils.Extend(SingleSelection, BaseSelection);

  SingleSelection.prototype.render = function () {
    var $selection = SingleSelection.__super__.render.call(this);

    $selection.addClass('select2-selection--single');

    $selection.html(
      '<span class="select2-selection__rendered"></span>' +
      '<span class="select2-selection__arrow" role="presentation">' +
        '<b role="presentation"></b>' +
      '</span>'
    );

    return $selection;
  };

  SingleSelection.prototype.bind = function (container, $container) {
    var self = this;

    SingleSelection.__super__.bind.apply(this, arguments);

    var id = container.id + '-container';

    this.$selection.find('.select2-selection__rendered').attr('id', id);
    this.$selection.attr('aria-labelledby', id);

    this.$selection.on('mousedown', function (evt) {
      // Only respond to left clicks
      if (evt.which !== 1) {
        return;
      }

      self.trigger('toggle', {
        originalEvent: evt
      });
    });

    this.$selection.on('focus', function (evt) {
      // User focuses on the container
    });

    this.$selection.on('blur', function (evt) {
      // User exits the container
    });

    container.on('focus', function (evt) {
      if (!container.isOpen()) {
        self.$selection.focus();
      }
    });

    container.on('selection:update', function (params) {
      self.update(params.data);
    });
  };

  SingleSelection.prototype.clear = function () {
    this.$selection.find('.select2-selection__rendered').empty();
  };

  SingleSelection.prototype.display = function (data, container) {
    var template = this.options.get('templateSelection');
    var escapeMarkup = this.options.get('escapeMarkup');

    return escapeMarkup(template(data, container));
  };

  SingleSelection.prototype.selectionContainer = function () {
    return $('<span></span>');
  };

  SingleSelection.prototype.update = function (data) {
    if (data.length === 0) {
      this.clear();
      return;
    }

    var selection = data[0];

    var $rendered = this.$selection.find('.select2-selection__rendered');
    var formatted = this.display(selection, $rendered);

    $rendered.empty().append(formatted);
    $rendered.prop('title', selection.title || selection.text);
  };

  return SingleSelection;
});

S2.define('select2/selection/multiple',[
  'jquery',
  './base',
  '../utils'
], function ($, BaseSelection, Utils) {
  function MultipleSelection ($element, options) {
    MultipleSelection.__super__.constructor.apply(this, arguments);
  }

  Utils.Extend(MultipleSelection, BaseSelection);

  MultipleSelection.prototype.render = function () {
    var $selection = MultipleSelection.__super__.render.call(this);

    $selection.addClass('select2-selection--multiple');

    $selection.html(
      '<ul class="select2-selection__rendered"></ul>'
    );

    return $selection;
  };

  MultipleSelection.prototype.bind = function (container, $container) {
    var self = this;

    MultipleSelection.__super__.bind.apply(this, arguments);

    this.$selection.on('click', function (evt) {
      self.trigger('toggle', {
        originalEvent: evt
      });
    });

    this.$selection.on(
      'click',
      '.select2-selection__choice__remove',
      function (evt) {
        // Ignore the event if it is disabled
        if (self.options.get('disabled')) {
          return;
        }

        var $remove = $(this);
        var $selection = $remove.parent();

        var data = $selection.data('data');

        self.trigger('unselect', {
          originalEvent: evt,
          data: data
        });
      }
    );
  };

  MultipleSelection.prototype.clear = function () {
    this.$selection.find('.select2-selection__rendered').empty();
  };

  MultipleSelection.prototype.display = function (data, container) {
    var template = this.options.get('templateSelection');
    var escapeMarkup = this.options.get('escapeMarkup');

    return escapeMarkup(template(data, container));
  };

  MultipleSelection.prototype.selectionContainer = function () {
    var $container = $(
      '<li class="select2-selection__choice">' +
        '<span class="select2-selection__choice__remove" role="presentation">' +
          '&times;' +
        '</span>' +
      '</li>'
    );

    return $container;
  };

  MultipleSelection.prototype.update = function (data) {
    this.clear();

    if (data.length === 0) {
      return;
    }

    var $selections = [];

    for (var d = 0; d < data.length; d++) {
      var selection = data[d];

      var $selection = this.selectionContainer();
      var formatted = this.display(selection, $selection);

      $selection.append(formatted);
      $selection.prop('title', selection.title || selection.text);

      $selection.data('data', selection);

      $selections.push($selection);
    }

    var $rendered = this.$selection.find('.select2-selection__rendered');

    Utils.appendMany($rendered, $selections);
  };

  return MultipleSelection;
});

S2.define('select2/selection/placeholder',[
  '../utils'
], function (Utils) {
  function Placeholder (decorated, $element, options) {
    this.placeholder = this.normalizePlaceholder(options.get('placeholder'));

    decorated.call(this, $element, options);
  }

  Placeholder.prototype.normalizePlaceholder = function (_, placeholder) {
    if (typeof placeholder === 'string') {
      placeholder = {
        id: '',
        text: placeholder
      };
    }

    return placeholder;
  };

  Placeholder.prototype.createPlaceholder = function (decorated, placeholder) {
    var $placeholder = this.selectionContainer();

    $placeholder.html(this.display(placeholder));
    $placeholder.addClass('select2-selection__placeholder')
                .removeClass('select2-selection__choice');

    return $placeholder;
  };

  Placeholder.prototype.update = function (decorated, data) {
    var singlePlaceholder = (
      data.length == 1 && data[0].id != this.placeholder.id
    );
    var multipleSelections = data.length > 1;

    if (multipleSelections || singlePlaceholder) {
      return decorated.call(this, data);
    }

    this.clear();

    var $placeholder = this.createPlaceholder(this.placeholder);

    this.$selection.find('.select2-selection__rendered').append($placeholder);
  };

  return Placeholder;
});

S2.define('select2/selection/allowClear',[
  'jquery',
  '../keys'
], function ($, KEYS) {
  function AllowClear () { }

  AllowClear.prototype.bind = function (decorated, container, $container) {
    var self = this;

    decorated.call(this, container, $container);

    if (this.placeholder == null) {
      if (this.options.get('debug') && window.console && console.error) {
        console.error(
          'Select2: The `allowClear` option should be used in combination ' +
          'with the `placeholder` option.'
        );
      }
    }

    this.$selection.on('mousedown', '.select2-selection__clear',
      function (evt) {
        self._handleClear(evt);
    });

    container.on('keypress', function (evt) {
      self._handleKeyboardClear(evt, container);
    });
  };

  AllowClear.prototype._handleClear = function (_, evt) {
    // Ignore the event if it is disabled
    if (this.options.get('disabled')) {
      return;
    }

    var $clear = this.$selection.find('.select2-selection__clear');

    // Ignore the event if nothing has been selected
    if ($clear.length === 0) {
      return;
    }

    evt.stopPropagation();

    var data = $clear.data('data');

    for (var d = 0; d < data.length; d++) {
      var unselectData = {
        data: data[d]
      };

      // Trigger the `unselect` event, so people can prevent it from being
      // cleared.
      this.trigger('unselect', unselectData);

      // If the event was prevented, don't clear it out.
      if (unselectData.prevented) {
        return;
      }
    }

    this.$element.val(this.placeholder.id).trigger('change');

    this.trigger('toggle', {});
  };

  AllowClear.prototype._handleKeyboardClear = function (_, evt, container) {
    if (container.isOpen()) {
      return;
    }

    if (evt.which == KEYS.DELETE || evt.which == KEYS.BACKSPACE) {
      this._handleClear(evt);
    }
  };

  AllowClear.prototype.update = function (decorated, data) {
    decorated.call(this, data);

    if (this.$selection.find('.select2-selection__placeholder').length > 0 ||
        data.length === 0) {
      return;
    }

    var $remove = $(
      '<span class="select2-selection__clear">' +
        '&times;' +
      '</span>'
    );
    $remove.data('data', data);

    this.$selection.find('.select2-selection__rendered').prepend($remove);
  };

  return AllowClear;
});

S2.define('select2/selection/search',[
  'jquery',
  '../utils',
  '../keys'
], function ($, Utils, KEYS) {
  function Search (decorated, $element, options) {
    decorated.call(this, $element, options);
  }

  Search.prototype.render = function (decorated) {
    var $search = $(
      '<li class="select2-search select2-search--inline">' +
        '<input class="select2-search__field" type="search" tabindex="-1"' +
        ' autocomplete="off" autocorrect="off" autocapitalize="off"' +
        ' spellcheck="false" role="textbox" aria-autocomplete="list" />' +
      '</li>'
    );

    this.$searchContainer = $search;
    this.$search = $search.find('input');

    var $rendered = decorated.call(this);

    this._transferTabIndex();

    return $rendered;
  };

  Search.prototype.bind = function (decorated, container, $container) {
    var self = this;

    decorated.call(this, container, $container);

    container.on('open', function () {
      self.$search.trigger('focus');
    });

    container.on('close', function () {
      self.$search.val('');
      self.$search.removeAttr('aria-activedescendant');
      self.$search.trigger('focus');
    });

    container.on('enable', function () {
      self.$search.prop('disabled', false);

      self._transferTabIndex();
    });

    container.on('disable', function () {
      self.$search.prop('disabled', true);
    });

    container.on('focus', function (evt) {
      self.$search.trigger('focus');
    });

    container.on('results:focus', function (params) {
      self.$search.attr('aria-activedescendant', params.id);
    });

    this.$selection.on('focusin', '.select2-search--inline', function (evt) {
      self.trigger('focus', evt);
    });

    this.$selection.on('focusout', '.select2-search--inline', function (evt) {
      self._handleBlur(evt);
    });

    this.$selection.on('keydown', '.select2-search--inline', function (evt) {
      evt.stopPropagation();

      self.trigger('keypress', evt);

      self._keyUpPrevented = evt.isDefaultPrevented();

      var key = evt.which;

      if (key === KEYS.BACKSPACE && self.$search.val() === '') {
        var $previousChoice = self.$searchContainer
          .prev('.select2-selection__choice');

        if ($previousChoice.length > 0) {
          var item = $previousChoice.data('data');

          self.searchRemoveChoice(item);

          evt.preventDefault();
        }
      }
    });

    // Try to detect the IE version should the `documentMode` property that
    // is stored on the document. This is only implemented in IE and is
    // slightly cleaner than doing a user agent check.
    // This property is not available in Edge, but Edge also doesn't have
    // this bug.
    var msie = document.documentMode;
    var disableInputEvents = msie && msie <= 11;

    // Workaround for browsers which do not support the `input` event
    // This will prevent double-triggering of events for browsers which support
    // both the `keyup` and `input` events.
    this.$selection.on(
      'input.searchcheck',
      '.select2-search--inline',
      function (evt) {
        // IE will trigger the `input` event when a placeholder is used on a
        // search box. To get around this issue, we are forced to ignore all
        // `input` events in IE and keep using `keyup`.
        if (disableInputEvents) {
          self.$selection.off('input.search input.searchcheck');
          return;
        }

        // Unbind the duplicated `keyup` event
        self.$selection.off('keyup.search');
      }
    );

    this.$selection.on(
      'keyup.search input.search',
      '.select2-search--inline',
      function (evt) {
        // IE will trigger the `input` event when a placeholder is used on a
        // search box. To get around this issue, we are forced to ignore all
        // `input` events in IE and keep using `keyup`.
        if (disableInputEvents && evt.type === 'input') {
          self.$selection.off('input.search input.searchcheck');
          return;
        }

        var key = evt.which;

        // We can freely ignore events from modifier keys
        if (key == KEYS.SHIFT || key == KEYS.CTRL || key == KEYS.ALT) {
          return;
        }

        // Tabbing will be handled during the `keydown` phase
        if (key == KEYS.TAB) {
          return;
        }

        self.handleSearch(evt);
      }
    );
  };

  /**
   * This method will transfer the tabindex attribute from the rendered
   * selection to the search box. This allows for the search box to be used as
   * the primary focus instead of the selection container.
   *
   * @private
   */
  Search.prototype._transferTabIndex = function (decorated) {
    this.$search.attr('tabindex', this.$selection.attr('tabindex'));
    this.$selection.attr('tabindex', '-1');
  };

  Search.prototype.createPlaceholder = function (decorated, placeholder) {
    this.$search.attr('placeholder', placeholder.text);
  };

  Search.prototype.update = function (decorated, data) {
    var searchHadFocus = this.$search[0] == document.activeElement;

    this.$search.attr('placeholder', '');

    decorated.call(this, data);

    this.$selection.find('.select2-selection__rendered')
                   .append(this.$searchContainer);

    this.resizeSearch();
    if (searchHadFocus) {
      this.$search.focus();
    }
  };

  Search.prototype.handleSearch = function () {
    this.resizeSearch();

    if (!this._keyUpPrevented) {
      var input = this.$search.val();

      this.trigger('query', {
        term: input
      });
    }

    this._keyUpPrevented = false;
  };

  Search.prototype.searchRemoveChoice = function (decorated, item) {
    this.trigger('unselect', {
      data: item
    });

    this.$search.val(item.text);
    this.handleSearch();
  };

  Search.prototype.resizeSearch = function () {
    this.$search.css('width', '25px');

    var width = '';

    if (this.$search.attr('placeholder') !== '') {
      width = this.$selection.find('.select2-selection__rendered').innerWidth();
    } else {
      var minimumWidth = this.$search.val().length + 1;

      width = (minimumWidth * 0.75) + 'em';
    }

    this.$search.css('width', width);
  };

  return Search;
});

S2.define('select2/selection/eventRelay',[
  'jquery'
], function ($) {
  function EventRelay () { }

  EventRelay.prototype.bind = function (decorated, container, $container) {
    var self = this;
    var relayEvents = [
      'open', 'opening',
      'close', 'closing',
      'select', 'selecting',
      'unselect', 'unselecting'
    ];

    var preventableEvents = ['opening', 'closing', 'selecting', 'unselecting'];

    decorated.call(this, container, $container);

    container.on('*', function (name, params) {
      // Ignore events that should not be relayed
      if ($.inArray(name, relayEvents) === -1) {
        return;
      }

      // The parameters should always be an object
      params = params || {};

      // Generate the jQuery event for the Select2 event
      var evt = $.Event('select2:' + name, {
        params: params
      });

      self.$element.trigger(evt);

      // Only handle preventable events if it was one
      if ($.inArray(name, preventableEvents) === -1) {
        return;
      }

      params.prevented = evt.isDefaultPrevented();
    });
  };

  return EventRelay;
});

S2.define('select2/translation',[
  'jquery',
  'require'
], function ($, require) {
  function Translation (dict) {
    this.dict = dict || {};
  }

  Translation.prototype.all = function () {
    return this.dict;
  };

  Translation.prototype.get = function (key) {
    return this.dict[key];
  };

  Translation.prototype.extend = function (translation) {
    this.dict = $.extend({}, translation.all(), this.dict);
  };

  // Static functions

  Translation._cache = {};

  Translation.loadPath = function (path) {
    if (!(path in Translation._cache)) {
      var translations = require(path);

      Translation._cache[path] = translations;
    }

    return new Translation(Translation._cache[path]);
  };

  return Translation;
});

S2.define('select2/diacritics',[

], function () {
  var diacritics = {
    '\u24B6': 'A',
    '\uFF21': 'A',
    '\u00C0': 'A',
    '\u00C1': 'A',
    '\u00C2': 'A',
    '\u1EA6': 'A',
    '\u1EA4': 'A',
    '\u1EAA': 'A',
    '\u1EA8': 'A',
    '\u00C3': 'A',
    '\u0100': 'A',
    '\u0102': 'A',
    '\u1EB0': 'A',
    '\u1EAE': 'A',
    '\u1EB4': 'A',
    '\u1EB2': 'A',
    '\u0226': 'A',
    '\u01E0': 'A',
    '\u00C4': 'A',
    '\u01DE': 'A',
    '\u1EA2': 'A',
    '\u00C5': 'A',
    '\u01FA': 'A',
    '\u01CD': 'A',
    '\u0200': 'A',
    '\u0202': 'A',
    '\u1EA0': 'A',
    '\u1EAC': 'A',
    '\u1EB6': 'A',
    '\u1E00': 'A',
    '\u0104': 'A',
    '\u023A': 'A',
    '\u2C6F': 'A',
    '\uA732': 'AA',
    '\u00C6': 'AE',
    '\u01FC': 'AE',
    '\u01E2': 'AE',
    '\uA734': 'AO',
    '\uA736': 'AU',
    '\uA738': 'AV',
    '\uA73A': 'AV',
    '\uA73C': 'AY',
    '\u24B7': 'B',
    '\uFF22': 'B',
    '\u1E02': 'B',
    '\u1E04': 'B',
    '\u1E06': 'B',
    '\u0243': 'B',
    '\u0182': 'B',
    '\u0181': 'B',
    '\u24B8': 'C',
    '\uFF23': 'C',
    '\u0106': 'C',
    '\u0108': 'C',
    '\u010A': 'C',
    '\u010C': 'C',
    '\u00C7': 'C',
    '\u1E08': 'C',
    '\u0187': 'C',
    '\u023B': 'C',
    '\uA73E': 'C',
    '\u24B9': 'D',
    '\uFF24': 'D',
    '\u1E0A': 'D',
    '\u010E': 'D',
    '\u1E0C': 'D',
    '\u1E10': 'D',
    '\u1E12': 'D',
    '\u1E0E': 'D',
    '\u0110': 'D',
    '\u018B': 'D',
    '\u018A': 'D',
    '\u0189': 'D',
    '\uA779': 'D',
    '\u01F1': 'DZ',
    '\u01C4': 'DZ',
    '\u01F2': 'Dz',
    '\u01C5': 'Dz',
    '\u24BA': 'E',
    '\uFF25': 'E',
    '\u00C8': 'E',
    '\u00C9': 'E',
    '\u00CA': 'E',
    '\u1EC0': 'E',
    '\u1EBE': 'E',
    '\u1EC4': 'E',
    '\u1EC2': 'E',
    '\u1EBC': 'E',
    '\u0112': 'E',
    '\u1E14': 'E',
    '\u1E16': 'E',
    '\u0114': 'E',
    '\u0116': 'E',
    '\u00CB': 'E',
    '\u1EBA': 'E',
    '\u011A': 'E',
    '\u0204': 'E',
    '\u0206': 'E',
    '\u1EB8': 'E',
    '\u1EC6': 'E',
    '\u0228': 'E',
    '\u1E1C': 'E',
    '\u0118': 'E',
    '\u1E18': 'E',
    '\u1E1A': 'E',
    '\u0190': 'E',
    '\u018E': 'E',
    '\u24BB': 'F',
    '\uFF26': 'F',
    '\u1E1E': 'F',
    '\u0191': 'F',
    '\uA77B': 'F',
    '\u24BC': 'G',
    '\uFF27': 'G',
    '\u01F4': 'G',
    '\u011C': 'G',
    '\u1E20': 'G',
    '\u011E': 'G',
    '\u0120': 'G',
    '\u01E6': 'G',
    '\u0122': 'G',
    '\u01E4': 'G',
    '\u0193': 'G',
    '\uA7A0': 'G',
    '\uA77D': 'G',
    '\uA77E': 'G',
    '\u24BD': 'H',
    '\uFF28': 'H',
    '\u0124': 'H',
    '\u1E22': 'H',
    '\u1E26': 'H',
    '\u021E': 'H',
    '\u1E24': 'H',
    '\u1E28': 'H',
    '\u1E2A': 'H',
    '\u0126': 'H',
    '\u2C67': 'H',
    '\u2C75': 'H',
    '\uA78D': 'H',
    '\u24BE': 'I',
    '\uFF29': 'I',
    '\u00CC': 'I',
    '\u00CD': 'I',
    '\u00CE': 'I',
    '\u0128': 'I',
    '\u012A': 'I',
    '\u012C': 'I',
    '\u0130': 'I',
    '\u00CF': 'I',
    '\u1E2E': 'I',
    '\u1EC8': 'I',
    '\u01CF': 'I',
    '\u0208': 'I',
    '\u020A': 'I',
    '\u1ECA': 'I',
    '\u012E': 'I',
    '\u1E2C': 'I',
    '\u0197': 'I',
    '\u24BF': 'J',
    '\uFF2A': 'J',
    '\u0134': 'J',
    '\u0248': 'J',
    '\u24C0': 'K',
    '\uFF2B': 'K',
    '\u1E30': 'K',
    '\u01E8': 'K',
    '\u1E32': 'K',
    '\u0136': 'K',
    '\u1E34': 'K',
    '\u0198': 'K',
    '\u2C69': 'K',
    '\uA740': 'K',
    '\uA742': 'K',
    '\uA744': 'K',
    '\uA7A2': 'K',
    '\u24C1': 'L',
    '\uFF2C': 'L',
    '\u013F': 'L',
    '\u0139': 'L',
    '\u013D': 'L',
    '\u1E36': 'L',
    '\u1E38': 'L',
    '\u013B': 'L',
    '\u1E3C': 'L',
    '\u1E3A': 'L',
    '\u0141': 'L',
    '\u023D': 'L',
    '\u2C62': 'L',
    '\u2C60': 'L',
    '\uA748': 'L',
    '\uA746': 'L',
    '\uA780': 'L',
    '\u01C7': 'LJ',
    '\u01C8': 'Lj',
    '\u24C2': 'M',
    '\uFF2D': 'M',
    '\u1E3E': 'M',
    '\u1E40': 'M',
    '\u1E42': 'M',
    '\u2C6E': 'M',
    '\u019C': 'M',
    '\u24C3': 'N',
    '\uFF2E': 'N',
    '\u01F8': 'N',
    '\u0143': 'N',
    '\u00D1': 'N',
    '\u1E44': 'N',
    '\u0147': 'N',
    '\u1E46': 'N',
    '\u0145': 'N',
    '\u1E4A': 'N',
    '\u1E48': 'N',
    '\u0220': 'N',
    '\u019D': 'N',
    '\uA790': 'N',
    '\uA7A4': 'N',
    '\u01CA': 'NJ',
    '\u01CB': 'Nj',
    '\u24C4': 'O',
    '\uFF2F': 'O',
    '\u00D2': 'O',
    '\u00D3': 'O',
    '\u00D4': 'O',
    '\u1ED2': 'O',
    '\u1ED0': 'O',
    '\u1ED6': 'O',
    '\u1ED4': 'O',
    '\u00D5': 'O',
    '\u1E4C': 'O',
    '\u022C': 'O',
    '\u1E4E': 'O',
    '\u014C': 'O',
    '\u1E50': 'O',
    '\u1E52': 'O',
    '\u014E': 'O',
    '\u022E': 'O',
    '\u0230': 'O',
    '\u00D6': 'O',
    '\u022A': 'O',
    '\u1ECE': 'O',
    '\u0150': 'O',
    '\u01D1': 'O',
    '\u020C': 'O',
    '\u020E': 'O',
    '\u01A0': 'O',
    '\u1EDC': 'O',
    '\u1EDA': 'O',
    '\u1EE0': 'O',
    '\u1EDE': 'O',
    '\u1EE2': 'O',
    '\u1ECC': 'O',
    '\u1ED8': 'O',
    '\u01EA': 'O',
    '\u01EC': 'O',
    '\u00D8': 'O',
    '\u01FE': 'O',
    '\u0186': 'O',
    '\u019F': 'O',
    '\uA74A': 'O',
    '\uA74C': 'O',
    '\u01A2': 'OI',
    '\uA74E': 'OO',
    '\u0222': 'OU',
    '\u24C5': 'P',
    '\uFF30': 'P',
    '\u1E54': 'P',
    '\u1E56': 'P',
    '\u01A4': 'P',
    '\u2C63': 'P',
    '\uA750': 'P',
    '\uA752': 'P',
    '\uA754': 'P',
    '\u24C6': 'Q',
    '\uFF31': 'Q',
    '\uA756': 'Q',
    '\uA758': 'Q',
    '\u024A': 'Q',
    '\u24C7': 'R',
    '\uFF32': 'R',
    '\u0154': 'R',
    '\u1E58': 'R',
    '\u0158': 'R',
    '\u0210': 'R',
    '\u0212': 'R',
    '\u1E5A': 'R',
    '\u1E5C': 'R',
    '\u0156': 'R',
    '\u1E5E': 'R',
    '\u024C': 'R',
    '\u2C64': 'R',
    '\uA75A': 'R',
    '\uA7A6': 'R',
    '\uA782': 'R',
    '\u24C8': 'S',
    '\uFF33': 'S',
    '\u1E9E': 'S',
    '\u015A': 'S',
    '\u1E64': 'S',
    '\u015C': 'S',
    '\u1E60': 'S',
    '\u0160': 'S',
    '\u1E66': 'S',
    '\u1E62': 'S',
    '\u1E68': 'S',
    '\u0218': 'S',
    '\u015E': 'S',
    '\u2C7E': 'S',
    '\uA7A8': 'S',
    '\uA784': 'S',
    '\u24C9': 'T',
    '\uFF34': 'T',
    '\u1E6A': 'T',
    '\u0164': 'T',
    '\u1E6C': 'T',
    '\u021A': 'T',
    '\u0162': 'T',
    '\u1E70': 'T',
    '\u1E6E': 'T',
    '\u0166': 'T',
    '\u01AC': 'T',
    '\u01AE': 'T',
    '\u023E': 'T',
    '\uA786': 'T',
    '\uA728': 'TZ',
    '\u24CA': 'U',
    '\uFF35': 'U',
    '\u00D9': 'U',
    '\u00DA': 'U',
    '\u00DB': 'U',
    '\u0168': 'U',
    '\u1E78': 'U',
    '\u016A': 'U',
    '\u1E7A': 'U',
    '\u016C': 'U',
    '\u00DC': 'U',
    '\u01DB': 'U',
    '\u01D7': 'U',
    '\u01D5': 'U',
    '\u01D9': 'U',
    '\u1EE6': 'U',
    '\u016E': 'U',
    '\u0170': 'U',
    '\u01D3': 'U',
    '\u0214': 'U',
    '\u0216': 'U',
    '\u01AF': 'U',
    '\u1EEA': 'U',
    '\u1EE8': 'U',
    '\u1EEE': 'U',
    '\u1EEC': 'U',
    '\u1EF0': 'U',
    '\u1EE4': 'U',
    '\u1E72': 'U',
    '\u0172': 'U',
    '\u1E76': 'U',
    '\u1E74': 'U',
    '\u0244': 'U',
    '\u24CB': 'V',
    '\uFF36': 'V',
    '\u1E7C': 'V',
    '\u1E7E': 'V',
    '\u01B2': 'V',
    '\uA75E': 'V',
    '\u0245': 'V',
    '\uA760': 'VY',
    '\u24CC': 'W',
    '\uFF37': 'W',
    '\u1E80': 'W',
    '\u1E82': 'W',
    '\u0174': 'W',
    '\u1E86': 'W',
    '\u1E84': 'W',
    '\u1E88': 'W',
    '\u2C72': 'W',
    '\u24CD': 'X',
    '\uFF38': 'X',
    '\u1E8A': 'X',
    '\u1E8C': 'X',
    '\u24CE': 'Y',
    '\uFF39': 'Y',
    '\u1EF2': 'Y',
    '\u00DD': 'Y',
    '\u0176': 'Y',
    '\u1EF8': 'Y',
    '\u0232': 'Y',
    '\u1E8E': 'Y',
    '\u0178': 'Y',
    '\u1EF6': 'Y',
    '\u1EF4': 'Y',
    '\u01B3': 'Y',
    '\u024E': 'Y',
    '\u1EFE': 'Y',
    '\u24CF': 'Z',
    '\uFF3A': 'Z',
    '\u0179': 'Z',
    '\u1E90': 'Z',
    '\u017B': 'Z',
    '\u017D': 'Z',
    '\u1E92': 'Z',
    '\u1E94': 'Z',
    '\u01B5': 'Z',
    '\u0224': 'Z',
    '\u2C7F': 'Z',
    '\u2C6B': 'Z',
    '\uA762': 'Z',
    '\u24D0': 'a',
    '\uFF41': 'a',
    '\u1E9A': 'a',
    '\u00E0': 'a',
    '\u00E1': 'a',
    '\u00E2': 'a',
    '\u1EA7': 'a',
    '\u1EA5': 'a',
    '\u1EAB': 'a',
    '\u1EA9': 'a',
    '\u00E3': 'a',
    '\u0101': 'a',
    '\u0103': 'a',
    '\u1EB1': 'a',
    '\u1EAF': 'a',
    '\u1EB5': 'a',
    '\u1EB3': 'a',
    '\u0227': 'a',
    '\u01E1': 'a',
    '\u00E4': 'a',
    '\u01DF': 'a',
    '\u1EA3': 'a',
    '\u00E5': 'a',
    '\u01FB': 'a',
    '\u01CE': 'a',
    '\u0201': 'a',
    '\u0203': 'a',
    '\u1EA1': 'a',
    '\u1EAD': 'a',
    '\u1EB7': 'a',
    '\u1E01': 'a',
    '\u0105': 'a',
    '\u2C65': 'a',
    '\u0250': 'a',
    '\uA733': 'aa',
    '\u00E6': 'ae',
    '\u01FD': 'ae',
    '\u01E3': 'ae',
    '\uA735': 'ao',
    '\uA737': 'au',
    '\uA739': 'av',
    '\uA73B': 'av',
    '\uA73D': 'ay',
    '\u24D1': 'b',
    '\uFF42': 'b',
    '\u1E03': 'b',
    '\u1E05': 'b',
    '\u1E07': 'b',
    '\u0180': 'b',
    '\u0183': 'b',
    '\u0253': 'b',
    '\u24D2': 'c',
    '\uFF43': 'c',
    '\u0107': 'c',
    '\u0109': 'c',
    '\u010B': 'c',
    '\u010D': 'c',
    '\u00E7': 'c',
    '\u1E09': 'c',
    '\u0188': 'c',
    '\u023C': 'c',
    '\uA73F': 'c',
    '\u2184': 'c',
    '\u24D3': 'd',
    '\uFF44': 'd',
    '\u1E0B': 'd',
    '\u010F': 'd',
    '\u1E0D': 'd',
    '\u1E11': 'd',
    '\u1E13': 'd',
    '\u1E0F': 'd',
    '\u0111': 'd',
    '\u018C': 'd',
    '\u0256': 'd',
    '\u0257': 'd',
    '\uA77A': 'd',
    '\u01F3': 'dz',
    '\u01C6': 'dz',
    '\u24D4': 'e',
    '\uFF45': 'e',
    '\u00E8': 'e',
    '\u00E9': 'e',
    '\u00EA': 'e',
    '\u1EC1': 'e',
    '\u1EBF': 'e',
    '\u1EC5': 'e',
    '\u1EC3': 'e',
    '\u1EBD': 'e',
    '\u0113': 'e',
    '\u1E15': 'e',
    '\u1E17': 'e',
    '\u0115': 'e',
    '\u0117': 'e',
    '\u00EB': 'e',
    '\u1EBB': 'e',
    '\u011B': 'e',
    '\u0205': 'e',
    '\u0207': 'e',
    '\u1EB9': 'e',
    '\u1EC7': 'e',
    '\u0229': 'e',
    '\u1E1D': 'e',
    '\u0119': 'e',
    '\u1E19': 'e',
    '\u1E1B': 'e',
    '\u0247': 'e',
    '\u025B': 'e',
    '\u01DD': 'e',
    '\u24D5': 'f',
    '\uFF46': 'f',
    '\u1E1F': 'f',
    '\u0192': 'f',
    '\uA77C': 'f',
    '\u24D6': 'g',
    '\uFF47': 'g',
    '\u01F5': 'g',
    '\u011D': 'g',
    '\u1E21': 'g',
    '\u011F': 'g',
    '\u0121': 'g',
    '\u01E7': 'g',
    '\u0123': 'g',
    '\u01E5': 'g',
    '\u0260': 'g',
    '\uA7A1': 'g',
    '\u1D79': 'g',
    '\uA77F': 'g',
    '\u24D7': 'h',
    '\uFF48': 'h',
    '\u0125': 'h',
    '\u1E23': 'h',
    '\u1E27': 'h',
    '\u021F': 'h',
    '\u1E25': 'h',
    '\u1E29': 'h',
    '\u1E2B': 'h',
    '\u1E96': 'h',
    '\u0127': 'h',
    '\u2C68': 'h',
    '\u2C76': 'h',
    '\u0265': 'h',
    '\u0195': 'hv',
    '\u24D8': 'i',
    '\uFF49': 'i',
    '\u00EC': 'i',
    '\u00ED': 'i',
    '\u00EE': 'i',
    '\u0129': 'i',
    '\u012B': 'i',
    '\u012D': 'i',
    '\u00EF': 'i',
    '\u1E2F': 'i',
    '\u1EC9': 'i',
    '\u01D0': 'i',
    '\u0209': 'i',
    '\u020B': 'i',
    '\u1ECB': 'i',
    '\u012F': 'i',
    '\u1E2D': 'i',
    '\u0268': 'i',
    '\u0131': 'i',
    '\u24D9': 'j',
    '\uFF4A': 'j',
    '\u0135': 'j',
    '\u01F0': 'j',
    '\u0249': 'j',
    '\u24DA': 'k',
    '\uFF4B': 'k',
    '\u1E31': 'k',
    '\u01E9': 'k',
    '\u1E33': 'k',
    '\u0137': 'k',
    '\u1E35': 'k',
    '\u0199': 'k',
    '\u2C6A': 'k',
    '\uA741': 'k',
    '\uA743': 'k',
    '\uA745': 'k',
    '\uA7A3': 'k',
    '\u24DB': 'l',
    '\uFF4C': 'l',
    '\u0140': 'l',
    '\u013A': 'l',
    '\u013E': 'l',
    '\u1E37': 'l',
    '\u1E39': 'l',
    '\u013C': 'l',
    '\u1E3D': 'l',
    '\u1E3B': 'l',
    '\u017F': 'l',
    '\u0142': 'l',
    '\u019A': 'l',
    '\u026B': 'l',
    '\u2C61': 'l',
    '\uA749': 'l',
    '\uA781': 'l',
    '\uA747': 'l',
    '\u01C9': 'lj',
    '\u24DC': 'm',
    '\uFF4D': 'm',
    '\u1E3F': 'm',
    '\u1E41': 'm',
    '\u1E43': 'm',
    '\u0271': 'm',
    '\u026F': 'm',
    '\u24DD': 'n',
    '\uFF4E': 'n',
    '\u01F9': 'n',
    '\u0144': 'n',
    '\u00F1': 'n',
    '\u1E45': 'n',
    '\u0148': 'n',
    '\u1E47': 'n',
    '\u0146': 'n',
    '\u1E4B': 'n',
    '\u1E49': 'n',
    '\u019E': 'n',
    '\u0272': 'n',
    '\u0149': 'n',
    '\uA791': 'n',
    '\uA7A5': 'n',
    '\u01CC': 'nj',
    '\u24DE': 'o',
    '\uFF4F': 'o',
    '\u00F2': 'o',
    '\u00F3': 'o',
    '\u00F4': 'o',
    '\u1ED3': 'o',
    '\u1ED1': 'o',
    '\u1ED7': 'o',
    '\u1ED5': 'o',
    '\u00F5': 'o',
    '\u1E4D': 'o',
    '\u022D': 'o',
    '\u1E4F': 'o',
    '\u014D': 'o',
    '\u1E51': 'o',
    '\u1E53': 'o',
    '\u014F': 'o',
    '\u022F': 'o',
    '\u0231': 'o',
    '\u00F6': 'o',
    '\u022B': 'o',
    '\u1ECF': 'o',
    '\u0151': 'o',
    '\u01D2': 'o',
    '\u020D': 'o',
    '\u020F': 'o',
    '\u01A1': 'o',
    '\u1EDD': 'o',
    '\u1EDB': 'o',
    '\u1EE1': 'o',
    '\u1EDF': 'o',
    '\u1EE3': 'o',
    '\u1ECD': 'o',
    '\u1ED9': 'o',
    '\u01EB': 'o',
    '\u01ED': 'o',
    '\u00F8': 'o',
    '\u01FF': 'o',
    '\u0254': 'o',
    '\uA74B': 'o',
    '\uA74D': 'o',
    '\u0275': 'o',
    '\u01A3': 'oi',
    '\u0223': 'ou',
    '\uA74F': 'oo',
    '\u24DF': 'p',
    '\uFF50': 'p',
    '\u1E55': 'p',
    '\u1E57': 'p',
    '\u01A5': 'p',
    '\u1D7D': 'p',
    '\uA751': 'p',
    '\uA753': 'p',
    '\uA755': 'p',
    '\u24E0': 'q',
    '\uFF51': 'q',
    '\u024B': 'q',
    '\uA757': 'q',
    '\uA759': 'q',
    '\u24E1': 'r',
    '\uFF52': 'r',
    '\u0155': 'r',
    '\u1E59': 'r',
    '\u0159': 'r',
    '\u0211': 'r',
    '\u0213': 'r',
    '\u1E5B': 'r',
    '\u1E5D': 'r',
    '\u0157': 'r',
    '\u1E5F': 'r',
    '\u024D': 'r',
    '\u027D': 'r',
    '\uA75B': 'r',
    '\uA7A7': 'r',
    '\uA783': 'r',
    '\u24E2': 's',
    '\uFF53': 's',
    '\u00DF': 's',
    '\u015B': 's',
    '\u1E65': 's',
    '\u015D': 's',
    '\u1E61': 's',
    '\u0161': 's',
    '\u1E67': 's',
    '\u1E63': 's',
    '\u1E69': 's',
    '\u0219': 's',
    '\u015F': 's',
    '\u023F': 's',
    '\uA7A9': 's',
    '\uA785': 's',
    '\u1E9B': 's',
    '\u24E3': 't',
    '\uFF54': 't',
    '\u1E6B': 't',
    '\u1E97': 't',
    '\u0165': 't',
    '\u1E6D': 't',
    '\u021B': 't',
    '\u0163': 't',
    '\u1E71': 't',
    '\u1E6F': 't',
    '\u0167': 't',
    '\u01AD': 't',
    '\u0288': 't',
    '\u2C66': 't',
    '\uA787': 't',
    '\uA729': 'tz',
    '\u24E4': 'u',
    '\uFF55': 'u',
    '\u00F9': 'u',
    '\u00FA': 'u',
    '\u00FB': 'u',
    '\u0169': 'u',
    '\u1E79': 'u',
    '\u016B': 'u',
    '\u1E7B': 'u',
    '\u016D': 'u',
    '\u00FC': 'u',
    '\u01DC': 'u',
    '\u01D8': 'u',
    '\u01D6': 'u',
    '\u01DA': 'u',
    '\u1EE7': 'u',
    '\u016F': 'u',
    '\u0171': 'u',
    '\u01D4': 'u',
    '\u0215': 'u',
    '\u0217': 'u',
    '\u01B0': 'u',
    '\u1EEB': 'u',
    '\u1EE9': 'u',
    '\u1EEF': 'u',
    '\u1EED': 'u',
    '\u1EF1': 'u',
    '\u1EE5': 'u',
    '\u1E73': 'u',
    '\u0173': 'u',
    '\u1E77': 'u',
    '\u1E75': 'u',
    '\u0289': 'u',
    '\u24E5': 'v',
    '\uFF56': 'v',
    '\u1E7D': 'v',
    '\u1E7F': 'v',
    '\u028B': 'v',
    '\uA75F': 'v',
    '\u028C': 'v',
    '\uA761': 'vy',
    '\u24E6': 'w',
    '\uFF57': 'w',
    '\u1E81': 'w',
    '\u1E83': 'w',
    '\u0175': 'w',
    '\u1E87': 'w',
    '\u1E85': 'w',
    '\u1E98': 'w',
    '\u1E89': 'w',
    '\u2C73': 'w',
    '\u24E7': 'x',
    '\uFF58': 'x',
    '\u1E8B': 'x',
    '\u1E8D': 'x',
    '\u24E8': 'y',
    '\uFF59': 'y',
    '\u1EF3': 'y',
    '\u00FD': 'y',
    '\u0177': 'y',
    '\u1EF9': 'y',
    '\u0233': 'y',
    '\u1E8F': 'y',
    '\u00FF': 'y',
    '\u1EF7': 'y',
    '\u1E99': 'y',
    '\u1EF5': 'y',
    '\u01B4': 'y',
    '\u024F': 'y',
    '\u1EFF': 'y',
    '\u24E9': 'z',
    '\uFF5A': 'z',
    '\u017A': 'z',
    '\u1E91': 'z',
    '\u017C': 'z',
    '\u017E': 'z',
    '\u1E93': 'z',
    '\u1E95': 'z',
    '\u01B6': 'z',
    '\u0225': 'z',
    '\u0240': 'z',
    '\u2C6C': 'z',
    '\uA763': 'z',
    '\u0386': '\u0391',
    '\u0388': '\u0395',
    '\u0389': '\u0397',
    '\u038A': '\u0399',
    '\u03AA': '\u0399',
    '\u038C': '\u039F',
    '\u038E': '\u03A5',
    '\u03AB': '\u03A5',
    '\u038F': '\u03A9',
    '\u03AC': '\u03B1',
    '\u03AD': '\u03B5',
    '\u03AE': '\u03B7',
    '\u03AF': '\u03B9',
    '\u03CA': '\u03B9',
    '\u0390': '\u03B9',
    '\u03CC': '\u03BF',
    '\u03CD': '\u03C5',
    '\u03CB': '\u03C5',
    '\u03B0': '\u03C5',
    '\u03C9': '\u03C9',
    '\u03C2': '\u03C3'
  };

  return diacritics;
});

S2.define('select2/data/base',[
  '../utils'
], function (Utils) {
  function BaseAdapter ($element, options) {
    BaseAdapter.__super__.constructor.call(this);
  }

  Utils.Extend(BaseAdapter, Utils.Observable);

  BaseAdapter.prototype.current = function (callback) {
    throw new Error('The `current` method must be defined in child classes.');
  };

  BaseAdapter.prototype.query = function (params, callback) {
    throw new Error('The `query` method must be defined in child classes.');
  };

  BaseAdapter.prototype.bind = function (container, $container) {
    // Can be implemented in subclasses
  };

  BaseAdapter.prototype.destroy = function () {
    // Can be implemented in subclasses
  };

  BaseAdapter.prototype.generateResultId = function (container, data) {
    var id = container.id + '-result-';

    id += Utils.generateChars(4);

    if (data.id != null) {
      id += '-' + data.id.toString();
    } else {
      id += '-' + Utils.generateChars(4);
    }
    return id;
  };

  return BaseAdapter;
});

S2.define('select2/data/select',[
  './base',
  '../utils',
  'jquery'
], function (BaseAdapter, Utils, $) {
  function SelectAdapter ($element, options) {
    this.$element = $element;
    this.options = options;

    SelectAdapter.__super__.constructor.call(this);
  }

  Utils.Extend(SelectAdapter, BaseAdapter);

  SelectAdapter.prototype.current = function (callback) {
    var data = [];
    var self = this;

    this.$element.find(':selected').each(function () {
      var $option = $(this);

      var option = self.item($option);

      data.push(option);
    });

    callback(data);
  };

  SelectAdapter.prototype.select = function (data) {
    var self = this;

    data.selected = true;

    // If data.element is a DOM node, use it instead
    if ($(data.element).is('option')) {
      data.element.selected = true;

      this.$element.trigger('change');

      return;
    }

    if (this.$element.prop('multiple')) {
      this.current(function (currentData) {
        var val = [];

        data = [data];
        data.push.apply(data, currentData);

        for (var d = 0; d < data.length; d++) {
          var id = data[d].id;

          if ($.inArray(id, val) === -1) {
            val.push(id);
          }
        }

        self.$element.val(val);
        self.$element.trigger('change');
      });
    } else {
      var val = data.id;

      this.$element.val(val);
      this.$element.trigger('change');
    }
  };

  SelectAdapter.prototype.unselect = function (data) {
    var self = this;

    if (!this.$element.prop('multiple')) {
      return;
    }

    data.selected = false;

    if ($(data.element).is('option')) {
      data.element.selected = false;

      this.$element.trigger('change');

      return;
    }

    this.current(function (currentData) {
      var val = [];

      for (var d = 0; d < currentData.length; d++) {
        var id = currentData[d].id;

        if (id !== data.id && $.inArray(id, val) === -1) {
          val.push(id);
        }
      }

      self.$element.val(val);

      self.$element.trigger('change');
    });
  };

  SelectAdapter.prototype.bind = function (container, $container) {
    var self = this;

    this.container = container;

    container.on('select', function (params) {
      self.select(params.data);
    });

    container.on('unselect', function (params) {
      self.unselect(params.data);
    });
  };

  SelectAdapter.prototype.destroy = function () {
    // Remove anything added to child elements
    this.$element.find('*').each(function () {
      // Remove any custom data set by Select2
      $.removeData(this, 'data');
    });
  };

  SelectAdapter.prototype.query = function (params, callback) {
    var data = [];
    var self = this;

    var $options = this.$element.children();

    $options.each(function () {
      var $option = $(this);

      if (!$option.is('option') && !$option.is('optgroup')) {
        return;
      }

      var option = self.item($option);

      var matches = self.matches(params, option);

      if (matches !== null) {
        data.push(matches);
      }
    });

    callback({
      results: data
    });
  };

  SelectAdapter.prototype.addOptions = function ($options) {
    Utils.appendMany(this.$element, $options);
  };

  SelectAdapter.prototype.option = function (data) {
    var option;

    if (data.children) {
      option = document.createElement('optgroup');
      option.label = data.text;
    } else {
      option = document.createElement('option');

      if (option.textContent !== undefined) {
        option.textContent = data.text;
      } else {
        option.innerText = data.text;
      }
    }

    if (data.id) {
      option.value = data.id;
    }

    if (data.disabled) {
      option.disabled = true;
    }

    if (data.selected) {
      option.selected = true;
    }

    if (data.title) {
      option.title = data.title;
    }

    var $option = $(option);

    var normalizedData = this._normalizeItem(data);
    normalizedData.element = option;

    // Override the option's data with the combined data
    $.data(option, 'data', normalizedData);

    return $option;
  };

  SelectAdapter.prototype.item = function ($option) {
    var data = {};

    data = $.data($option[0], 'data');

    if (data != null) {
      return data;
    }

    if ($option.is('option')) {
      data = {
        id: $option.val(),
        text: $option.text(),
        disabled: $option.prop('disabled'),
        selected: $option.prop('selected'),
        title: $option.prop('title')
      };
    } else if ($option.is('optgroup')) {
      data = {
        text: $option.prop('label'),
        children: [],
        title: $option.prop('title')
      };

      var $children = $option.children('option');
      var children = [];

      for (var c = 0; c < $children.length; c++) {
        var $child = $($children[c]);

        var child = this.item($child);

        children.push(child);
      }

      data.children = children;
    }

    data = this._normalizeItem(data);
    data.element = $option[0];

    $.data($option[0], 'data', data);

    return data;
  };

  SelectAdapter.prototype._normalizeItem = function (item) {
    if (!$.isPlainObject(item)) {
      item = {
        id: item,
        text: item
      };
    }

    item = $.extend({}, {
      text: ''
    }, item);

    var defaults = {
      selected: false,
      disabled: false
    };

    if (item.id != null) {
      item.id = item.id.toString();
    }

    if (item.text != null) {
      item.text = item.text.toString();
    }

    if (item._resultId == null && item.id && this.container != null) {
      item._resultId = this.generateResultId(this.container, item);
    }

    return $.extend({}, defaults, item);
  };

  SelectAdapter.prototype.matches = function (params, data) {
    var matcher = this.options.get('matcher');

    return matcher(params, data);
  };

  return SelectAdapter;
});

S2.define('select2/data/array',[
  './select',
  '../utils',
  'jquery'
], function (SelectAdapter, Utils, $) {
  function ArrayAdapter ($element, options) {
    var data = options.get('data') || [];

    ArrayAdapter.__super__.constructor.call(this, $element, options);

    this.addOptions(this.convertToOptions(data));
  }

  Utils.Extend(ArrayAdapter, SelectAdapter);

  ArrayAdapter.prototype.select = function (data) {
    var $option = this.$element.find('option').filter(function (i, elm) {
      return elm.value == data.id.toString();
    });

    if ($option.length === 0) {
      $option = this.option(data);

      this.addOptions($option);
    }

    ArrayAdapter.__super__.select.call(this, data);
  };

  ArrayAdapter.prototype.convertToOptions = function (data) {
    var self = this;

    var $existing = this.$element.find('option');
    var existingIds = $existing.map(function () {
      return self.item($(this)).id;
    }).get();

    var $options = [];

    // Filter out all items except for the one passed in the argument
    function onlyItem (item) {
      return function () {
        return $(this).val() == item.id;
      };
    }

    for (var d = 0; d < data.length; d++) {
      var item = this._normalizeItem(data[d]);

      // Skip items which were pre-loaded, only merge the data
      if ($.inArray(item.id, existingIds) >= 0) {
        var $existingOption = $existing.filter(onlyItem(item));

        var existingData = this.item($existingOption);
        var newData = $.extend(true, {}, item, existingData);

        var $newOption = this.option(newData);

        $existingOption.replaceWith($newOption);

        continue;
      }

      var $option = this.option(item);

      if (item.children) {
        var $children = this.convertToOptions(item.children);

        Utils.appendMany($option, $children);
      }

      $options.push($option);
    }

    return $options;
  };

  return ArrayAdapter;
});

S2.define('select2/data/ajax',[
  './array',
  '../utils',
  'jquery'
], function (ArrayAdapter, Utils, $) {
  function AjaxAdapter ($element, options) {
    this.ajaxOptions = this._applyDefaults(options.get('ajax'));

    if (this.ajaxOptions.processResults != null) {
      this.processResults = this.ajaxOptions.processResults;
    }

    AjaxAdapter.__super__.constructor.call(this, $element, options);
  }

  Utils.Extend(AjaxAdapter, ArrayAdapter);

  AjaxAdapter.prototype._applyDefaults = function (options) {
    var defaults = {
      data: function (params) {
        return $.extend({}, params, {
          q: params.term
        });
      },
      transport: function (params, success, failure) {
        var $request = $.ajax(params);

        $request.then(success);
        $request.fail(failure);

        return $request;
      }
    };

    return $.extend({}, defaults, options, true);
  };

  AjaxAdapter.prototype.processResults = function (results) {
    return results;
  };

  AjaxAdapter.prototype.query = function (params, callback) {
    var matches = [];
    var self = this;

    if (this._request != null) {
      // JSONP requests cannot always be aborted
      if ($.isFunction(this._request.abort)) {
        this._request.abort();
      }

      this._request = null;
    }

    var options = $.extend({
      type: 'GET'
    }, this.ajaxOptions);

    if (typeof options.url === 'function') {
      options.url = options.url.call(this.$element, params);
    }

    if (typeof options.data === 'function') {
      options.data = options.data.call(this.$element, params);
    }

    function request () {
      var $request = options.transport(options, function (data) {
        var results = self.processResults(data, params);

        if (self.options.get('debug') && window.console && console.error) {
          // Check to make sure that the response included a `results` key.
          if (!results || !results.results || !$.isArray(results.results)) {
            console.error(
              'Select2: The AJAX results did not return an array in the ' +
              '`results` key of the response.'
            );
          }
        }

        callback(results);
      }, function () {
        // Attempt to detect if a request was aborted
        // Only works if the transport exposes a status property
        if ($request.status && $request.status === '0') {
          return;
        }

        self.trigger('results:message', {
          message: 'errorLoading'
        });
      });

      self._request = $request;
    }

    if (this.ajaxOptions.delay && params.term != null) {
      if (this._queryTimeout) {
        window.clearTimeout(this._queryTimeout);
      }

      this._queryTimeout = window.setTimeout(request, this.ajaxOptions.delay);
    } else {
      request();
    }
  };

  return AjaxAdapter;
});

S2.define('select2/data/tags',[
  'jquery'
], function ($) {
  function Tags (decorated, $element, options) {
    var tags = options.get('tags');

    var createTag = options.get('createTag');

    if (createTag !== undefined) {
      this.createTag = createTag;
    }

    var insertTag = options.get('insertTag');

    if (insertTag !== undefined) {
        this.insertTag = insertTag;
    }

    decorated.call(this, $element, options);

    if ($.isArray(tags)) {
      for (var t = 0; t < tags.length; t++) {
        var tag = tags[t];
        var item = this._normalizeItem(tag);

        var $option = this.option(item);

        this.$element.append($option);
      }
    }
  }

  Tags.prototype.query = function (decorated, params, callback) {
    var self = this;

    this._removeOldTags();

    if (params.term == null || params.page != null) {
      decorated.call(this, params, callback);
      return;
    }

    function wrapper (obj, child) {
      var data = obj.results;

      for (var i = 0; i < data.length; i++) {
        var option = data[i];

        var checkChildren = (
          option.children != null &&
          !wrapper({
            results: option.children
          }, true)
        );

        var checkText = option.text === params.term;

        if (checkText || checkChildren) {
          if (child) {
            return false;
          }

          obj.data = data;
          callback(obj);

          return;
        }
      }

      if (child) {
        return true;
      }

      var tag = self.createTag(params);

      if (tag != null) {
        var $option = self.option(tag);
        $option.attr('data-select2-tag', true);

        self.addOptions([$option]);

        self.insertTag(data, tag);
      }

      obj.results = data;

      callback(obj);
    }

    decorated.call(this, params, wrapper);
  };

  Tags.prototype.createTag = function (decorated, params) {
    var term = $.trim(params.term);

    if (term === '') {
      return null;
    }

    return {
      id: term,
      text: term
    };
  };

  Tags.prototype.insertTag = function (_, data, tag) {
    data.unshift(tag);
  };

  Tags.prototype._removeOldTags = function (_) {
    var tag = this._lastTag;

    var $options = this.$element.find('option[data-select2-tag]');

    $options.each(function () {
      if (this.selected) {
        return;
      }

      $(this).remove();
    });
  };

  return Tags;
});

S2.define('select2/data/tokenizer',[
  'jquery'
], function ($) {
  function Tokenizer (decorated, $element, options) {
    var tokenizer = options.get('tokenizer');

    if (tokenizer !== undefined) {
      this.tokenizer = tokenizer;
    }

    decorated.call(this, $element, options);
  }

  Tokenizer.prototype.bind = function (decorated, container, $container) {
    decorated.call(this, container, $container);

    this.$search =  container.dropdown.$search || container.selection.$search ||
      $container.find('.select2-search__field');
  };

  Tokenizer.prototype.query = function (decorated, params, callback) {
    var self = this;

    function createAndSelect (data) {
      // Normalize the data object so we can use it for checks
      var item = self._normalizeItem(data);

      // Check if the data object already exists as a tag
      // Select it if it doesn't
      var $existingOptions = self.$element.find('option').filter(function () {
        return $(this).val() === item.id;
      });

      // If an existing option wasn't found for it, create the option
      if (!$existingOptions.length) {
        var $option = self.option(item);
        $option.attr('data-select2-tag', true);

        self._removeOldTags();
        self.addOptions([$option]);
      }

      // Select the item, now that we know there is an option for it
      select(item);
    }

    function select (data) {
      self.trigger('select', {
        data: data
      });
    }

    params.term = params.term || '';

    var tokenData = this.tokenizer(params, this.options, createAndSelect);

    if (tokenData.term !== params.term) {
      // Replace the search term if we have the search box
      if (this.$search.length) {
        this.$search.val(tokenData.term);
        this.$search.focus();
      }

      params.term = tokenData.term;
    }

    decorated.call(this, params, callback);
  };

  Tokenizer.prototype.tokenizer = function (_, params, options, callback) {
    var separators = options.get('tokenSeparators') || [];
    var term = params.term;
    var i = 0;

    var createTag = this.createTag || function (params) {
      return {
        id: params.term,
        text: params.term
      };
    };

    while (i < term.length) {
      var termChar = term[i];

      if ($.inArray(termChar, separators) === -1) {
        i++;

        continue;
      }

      var part = term.substr(0, i);
      var partParams = $.extend({}, params, {
        term: part
      });

      var data = createTag(partParams);

      if (data == null) {
        i++;
        continue;
      }

      callback(data);

      // Reset the term to not include the tokenized portion
      term = term.substr(i + 1) || '';
      i = 0;
    }

    return {
      term: term
    };
  };

  return Tokenizer;
});

S2.define('select2/data/minimumInputLength',[

], function () {
  function MinimumInputLength (decorated, $e, options) {
    this.minimumInputLength = options.get('minimumInputLength');

    decorated.call(this, $e, options);
  }

  MinimumInputLength.prototype.query = function (decorated, params, callback) {
    params.term = params.term || '';

    if (params.term.length < this.minimumInputLength) {
      this.trigger('results:message', {
        message: 'inputTooShort',
        args: {
          minimum: this.minimumInputLength,
          input: params.term,
          params: params
        }
      });

      return;
    }

    decorated.call(this, params, callback);
  };

  return MinimumInputLength;
});

S2.define('select2/data/maximumInputLength',[

], function () {
  function MaximumInputLength (decorated, $e, options) {
    this.maximumInputLength = options.get('maximumInputLength');

    decorated.call(this, $e, options);
  }

  MaximumInputLength.prototype.query = function (decorated, params, callback) {
    params.term = params.term || '';

    if (this.maximumInputLength > 0 &&
        params.term.length > this.maximumInputLength) {
      this.trigger('results:message', {
        message: 'inputTooLong',
        args: {
          maximum: this.maximumInputLength,
          input: params.term,
          params: params
        }
      });

      return;
    }

    decorated.call(this, params, callback);
  };

  return MaximumInputLength;
});

S2.define('select2/data/maximumSelectionLength',[

], function (){
  function MaximumSelectionLength (decorated, $e, options) {
    this.maximumSelectionLength = options.get('maximumSelectionLength');

    decorated.call(this, $e, options);
  }

  MaximumSelectionLength.prototype.query =
    function (decorated, params, callback) {
      var self = this;

      this.current(function (currentData) {
        var count = currentData != null ? currentData.length : 0;
        if (self.maximumSelectionLength > 0 &&
          count >= self.maximumSelectionLength) {
          self.trigger('results:message', {
            message: 'maximumSelected',
            args: {
              maximum: self.maximumSelectionLength
            }
          });
          return;
        }
        decorated.call(self, params, callback);
      });
  };

  return MaximumSelectionLength;
});

S2.define('select2/dropdown',[
  'jquery',
  './utils'
], function ($, Utils) {
  function Dropdown ($element, options) {
    this.$element = $element;
    this.options = options;

    Dropdown.__super__.constructor.call(this);
  }

  Utils.Extend(Dropdown, Utils.Observable);

  Dropdown.prototype.render = function () {
    var $dropdown = $(
      '<span class="select2-dropdown">' +
        '<span class="select2-results"></span>' +
      '</span>'
    );

    $dropdown.attr('dir', this.options.get('dir'));

    this.$dropdown = $dropdown;

    return $dropdown;
  };

  Dropdown.prototype.bind = function () {
    // Should be implemented in subclasses
  };

  Dropdown.prototype.position = function ($dropdown, $container) {
    // Should be implmented in subclasses
  };

  Dropdown.prototype.destroy = function () {
    // Remove the dropdown from the DOM
    this.$dropdown.remove();
  };

  return Dropdown;
});

S2.define('select2/dropdown/search',[
  'jquery',
  '../utils'
], function ($, Utils) {
  function Search () { }

  Search.prototype.render = function (decorated) {
    var $rendered = decorated.call(this);

    var $search = $(
      '<span class="select2-search select2-search--dropdown">' +
        '<input class="select2-search__field" type="search" tabindex="-1"' +
        ' autocomplete="off" autocorrect="off" autocapitalize="off"' +
        ' spellcheck="false" role="textbox" />' +
      '</span>'
    );

    this.$searchContainer = $search;
    this.$search = $search.find('input');

    $rendered.prepend($search);

    return $rendered;
  };

  Search.prototype.bind = function (decorated, container, $container) {
    var self = this;

    decorated.call(this, container, $container);

    this.$search.on('keydown', function (evt) {
      self.trigger('keypress', evt);

      self._keyUpPrevented = evt.isDefaultPrevented();
    });

    // Workaround for browsers which do not support the `input` event
    // This will prevent double-triggering of events for browsers which support
    // both the `keyup` and `input` events.
    this.$search.on('input', function (evt) {
      // Unbind the duplicated `keyup` event
      $(this).off('keyup');
    });

    this.$search.on('keyup input', function (evt) {
      self.handleSearch(evt);
    });

    container.on('open', function () {
      self.$search.attr('tabindex', 0);

      self.$search.focus();

      window.setTimeout(function () {
        self.$search.focus();
      }, 0);
    });

    container.on('close', function () {
      self.$search.attr('tabindex', -1);

      self.$search.val('');
    });

    container.on('focus', function () {
      if (container.isOpen()) {
        self.$search.focus();
      }
    });

    container.on('results:all', function (params) {
      if (params.query.term == null || params.query.term === '') {
        var showSearch = self.showSearch(params);

        if (showSearch) {
          self.$searchContainer.removeClass('select2-search--hide');
        } else {
          self.$searchContainer.addClass('select2-search--hide');
        }
      }
    });
  };

  Search.prototype.handleSearch = function (evt) {
    if (!this._keyUpPrevented) {
      var input = this.$search.val();

      this.trigger('query', {
        term: input
      });
    }

    this._keyUpPrevented = false;
  };

  Search.prototype.showSearch = function (_, params) {
    return true;
  };

  return Search;
});

S2.define('select2/dropdown/hidePlaceholder',[

], function () {
  function HidePlaceholder (decorated, $element, options, dataAdapter) {
    this.placeholder = this.normalizePlaceholder(options.get('placeholder'));

    decorated.call(this, $element, options, dataAdapter);
  }

  HidePlaceholder.prototype.append = function (decorated, data) {
    data.results = this.removePlaceholder(data.results);

    decorated.call(this, data);
  };

  HidePlaceholder.prototype.normalizePlaceholder = function (_, placeholder) {
    if (typeof placeholder === 'string') {
      placeholder = {
        id: '',
        text: placeholder
      };
    }

    return placeholder;
  };

  HidePlaceholder.prototype.removePlaceholder = function (_, data) {
    var modifiedData = data.slice(0);

    for (var d = data.length - 1; d >= 0; d--) {
      var item = data[d];

      if (this.placeholder.id === item.id) {
        modifiedData.splice(d, 1);
      }
    }

    return modifiedData;
  };

  return HidePlaceholder;
});

S2.define('select2/dropdown/infiniteScroll',[
  'jquery'
], function ($) {
  function InfiniteScroll (decorated, $element, options, dataAdapter) {
    this.lastParams = {};

    decorated.call(this, $element, options, dataAdapter);

    this.$loadingMore = this.createLoadingMore();
    this.loading = false;
  }

  InfiniteScroll.prototype.append = function (decorated, data) {
    this.$loadingMore.remove();
    this.loading = false;

    decorated.call(this, data);

    if (this.showLoadingMore(data)) {
      this.$results.append(this.$loadingMore);
    }
  };

  InfiniteScroll.prototype.bind = function (decorated, container, $container) {
    var self = this;

    decorated.call(this, container, $container);

    container.on('query', function (params) {
      self.lastParams = params;
      self.loading = true;
    });

    container.on('query:append', function (params) {
      self.lastParams = params;
      self.loading = true;
    });

    this.$results.on('scroll', function () {
      var isLoadMoreVisible = $.contains(
        document.documentElement,
        self.$loadingMore[0]
      );

      if (self.loading || !isLoadMoreVisible) {
        return;
      }

      var currentOffset = self.$results.offset().top +
        self.$results.outerHeight(false);
      var loadingMoreOffset = self.$loadingMore.offset().top +
        self.$loadingMore.outerHeight(false);

      if (currentOffset + 50 >= loadingMoreOffset) {
        self.loadMore();
      }
    });
  };

  InfiniteScroll.prototype.loadMore = function () {
    this.loading = true;

    var params = $.extend({}, {page: 1}, this.lastParams);

    params.page++;

    this.trigger('query:append', params);
  };

  InfiniteScroll.prototype.showLoadingMore = function (_, data) {
    return data.pagination && data.pagination.more;
  };

  InfiniteScroll.prototype.createLoadingMore = function () {
    var $option = $(
      '<li ' +
      'class="select2-results__option select2-results__option--load-more"' +
      'role="treeitem" aria-disabled="true"></li>'
    );

    var message = this.options.get('translations').get('loadingMore');

    $option.html(message(this.lastParams));

    return $option;
  };

  return InfiniteScroll;
});

S2.define('select2/dropdown/attachBody',[
  'jquery',
  '../utils'
], function ($, Utils) {
  function AttachBody (decorated, $element, options) {
    this.$dropdownParent = options.get('dropdownParent') || $(document.body);

    decorated.call(this, $element, options);
  }

  AttachBody.prototype.bind = function (decorated, container, $container) {
    var self = this;

    var setupResultsEvents = false;

    decorated.call(this, container, $container);

    container.on('open', function () {
      self._showDropdown();
      self._attachPositioningHandler(container);

      if (!setupResultsEvents) {
        setupResultsEvents = true;

        container.on('results:all', function () {
          self._positionDropdown();
          self._resizeDropdown();
        });

        container.on('results:append', function () {
          self._positionDropdown();
          self._resizeDropdown();
        });
      }
    });

    container.on('close', function () {
      self._hideDropdown();
      self._detachPositioningHandler(container);
    });

    this.$dropdownContainer.on('mousedown', function (evt) {
      evt.stopPropagation();
    });
  };

  AttachBody.prototype.destroy = function (decorated) {
    decorated.call(this);

    this.$dropdownContainer.remove();
  };

  AttachBody.prototype.position = function (decorated, $dropdown, $container) {
    // Clone all of the container classes
    $dropdown.attr('class', $container.attr('class'));

    $dropdown.removeClass('select2');
    $dropdown.addClass('select2-container--open');

    $dropdown.css({
      position: 'absolute',
      top: -999999
    });

    this.$container = $container;
  };

  AttachBody.prototype.render = function (decorated) {
    var $container = $('<span></span>');

    var $dropdown = decorated.call(this);
    $container.append($dropdown);

    this.$dropdownContainer = $container;

    return $container;
  };

  AttachBody.prototype._hideDropdown = function (decorated) {
    this.$dropdownContainer.detach();
  };

  AttachBody.prototype._attachPositioningHandler =
      function (decorated, container) {
    var self = this;

    var scrollEvent = 'scroll.select2.' + container.id;
    var resizeEvent = 'resize.select2.' + container.id;
    var orientationEvent = 'orientationchange.select2.' + container.id;

    var $watchers = this.$container.parents().filter(Utils.hasScroll);
    $watchers.each(function () {
      $(this).data('select2-scroll-position', {
        x: $(this).scrollLeft(),
        y: $(this).scrollTop()
      });
    });

    $watchers.on(scrollEvent, function (ev) {
      var position = $(this).data('select2-scroll-position');
      $(this).scrollTop(position.y);
    });

    $(window).on(scrollEvent + ' ' + resizeEvent + ' ' + orientationEvent,
      function (e) {
      self._positionDropdown();
      self._resizeDropdown();
    });
  };

  AttachBody.prototype._detachPositioningHandler =
      function (decorated, container) {
    var scrollEvent = 'scroll.select2.' + container.id;
    var resizeEvent = 'resize.select2.' + container.id;
    var orientationEvent = 'orientationchange.select2.' + container.id;

    var $watchers = this.$container.parents().filter(Utils.hasScroll);
    $watchers.off(scrollEvent);

    $(window).off(scrollEvent + ' ' + resizeEvent + ' ' + orientationEvent);
  };

  AttachBody.prototype._positionDropdown = function () {
    var $window = $(window);

    var isCurrentlyAbove = this.$dropdown.hasClass('select2-dropdown--above');
    var isCurrentlyBelow = this.$dropdown.hasClass('select2-dropdown--below');

    var newDirection = null;

    var offset = this.$container.offset();

    offset.bottom = offset.top + this.$container.outerHeight(false);

    var container = {
      height: this.$container.outerHeight(false)
    };

    container.top = offset.top;
    container.bottom = offset.top + container.height;

    var dropdown = {
      height: this.$dropdown.outerHeight(false)
    };

    var viewport = {
      top: $window.scrollTop(),
      bottom: $window.scrollTop() + $window.height()
    };

    var enoughRoomAbove = viewport.top < (offset.top - dropdown.height);
    var enoughRoomBelow = viewport.bottom > (offset.bottom + dropdown.height);

    var css = {
      left: offset.left,
      top: container.bottom
    };

    // Determine what the parent element is to use for calciulating the offset
    var $offsetParent = this.$dropdownParent;

    // For statically positoned elements, we need to get the element
    // that is determining the offset
    if ($offsetParent.css('position') === 'static') {
      $offsetParent = $offsetParent.offsetParent();
    }

    var parentOffset = $offsetParent.offset();

    css.top -= parentOffset.top;
    css.left -= parentOffset.left;

    if (!isCurrentlyAbove && !isCurrentlyBelow) {
      newDirection = 'below';
    }

    if (!enoughRoomBelow && enoughRoomAbove && !isCurrentlyAbove) {
      newDirection = 'above';
    } else if (!enoughRoomAbove && enoughRoomBelow && isCurrentlyAbove) {
      newDirection = 'below';
    }

    if (newDirection == 'above' ||
      (isCurrentlyAbove && newDirection !== 'below')) {
      css.top = container.top - parentOffset.top - dropdown.height;
    }

    if (newDirection != null) {
      this.$dropdown
        .removeClass('select2-dropdown--below select2-dropdown--above')
        .addClass('select2-dropdown--' + newDirection);
      this.$container
        .removeClass('select2-container--below select2-container--above')
        .addClass('select2-container--' + newDirection);
    }

    this.$dropdownContainer.css(css);
  };

  AttachBody.prototype._resizeDropdown = function () {
    var css = {
      width: this.$container.outerWidth(false) + 'px'
    };

    if (this.options.get('dropdownAutoWidth')) {
      css.minWidth = css.width;
      css.position = 'relative';
      css.width = 'auto';
    }

    this.$dropdown.css(css);
  };

  AttachBody.prototype._showDropdown = function (decorated) {
    this.$dropdownContainer.appendTo(this.$dropdownParent);

    this._positionDropdown();
    this._resizeDropdown();
  };

  return AttachBody;
});

S2.define('select2/dropdown/minimumResultsForSearch',[

], function () {
  function countResults (data) {
    var count = 0;

    for (var d = 0; d < data.length; d++) {
      var item = data[d];

      if (item.children) {
        count += countResults(item.children);
      } else {
        count++;
      }
    }

    return count;
  }

  function MinimumResultsForSearch (decorated, $element, options, dataAdapter) {
    this.minimumResultsForSearch = options.get('minimumResultsForSearch');

    if (this.minimumResultsForSearch < 0) {
      this.minimumResultsForSearch = Infinity;
    }

    decorated.call(this, $element, options, dataAdapter);
  }

  MinimumResultsForSearch.prototype.showSearch = function (decorated, params) {
    if (countResults(params.data.results) < this.minimumResultsForSearch) {
      return false;
    }

    return decorated.call(this, params);
  };

  return MinimumResultsForSearch;
});

S2.define('select2/dropdown/selectOnClose',[

], function () {
  function SelectOnClose () { }

  SelectOnClose.prototype.bind = function (decorated, container, $container) {
    var self = this;

    decorated.call(this, container, $container);

    container.on('close', function (params) {
      self._handleSelectOnClose(params);
    });
  };

  SelectOnClose.prototype._handleSelectOnClose = function (_, params) {
    if (params && params.originalSelect2Event != null) {
      var event = params.originalSelect2Event;

      // Don't select an item if the close event was triggered from a select or
      // unselect event
      if (event._type === 'select' || event._type === 'unselect') {
        return;
      }
    }

    var $highlightedResults = this.getHighlightedResults();

    // Only select highlighted results
    if ($highlightedResults.length < 1) {
      return;
    }

    var data = $highlightedResults.data('data');

    // Don't re-select already selected resulte
    if (
      (data.element != null && data.element.selected) ||
      (data.element == null && data.selected)
    ) {
      return;
    }

    this.trigger('select', {
        data: data
    });
  };

  return SelectOnClose;
});

S2.define('select2/dropdown/closeOnSelect',[

], function () {
  function CloseOnSelect () { }

  CloseOnSelect.prototype.bind = function (decorated, container, $container) {
    var self = this;

    decorated.call(this, container, $container);

    container.on('select', function (evt) {
      self._selectTriggered(evt);
    });

    container.on('unselect', function (evt) {
      self._selectTriggered(evt);
    });
  };

  CloseOnSelect.prototype._selectTriggered = function (_, evt) {
    var originalEvent = evt.originalEvent;

    // Don't close if the control key is being held
    if (originalEvent && originalEvent.ctrlKey) {
      return;
    }

    this.trigger('close', {
      originalEvent: originalEvent,
      originalSelect2Event: evt
    });
  };

  return CloseOnSelect;
});

S2.define('select2/i18n/en',[],function () {
  // English
  return {
    errorLoading: function () {
      return 'The results could not be loaded.';
    },
    inputTooLong: function (args) {
      var overChars = args.input.length - args.maximum;

      var message = 'Please delete ' + overChars + ' character';

      if (overChars != 1) {
        message += 's';
      }

      return message;
    },
    inputTooShort: function (args) {
      var remainingChars = args.minimum - args.input.length;

      var message = 'Please enter ' + remainingChars + ' or more characters';

      return message;
    },
    loadingMore: function () {
      return 'Loading more results…';
    },
    maximumSelected: function (args) {
      var message = 'You can only select ' + args.maximum + ' item';

      if (args.maximum != 1) {
        message += 's';
      }

      return message;
    },
    noResults: function () {
      return 'No results found';
    },
    searching: function () {
      return 'Searching…';
    }
  };
});

S2.define('select2/defaults',[
  'jquery',
  'require',

  './results',

  './selection/single',
  './selection/multiple',
  './selection/placeholder',
  './selection/allowClear',
  './selection/search',
  './selection/eventRelay',

  './utils',
  './translation',
  './diacritics',

  './data/select',
  './data/array',
  './data/ajax',
  './data/tags',
  './data/tokenizer',
  './data/minimumInputLength',
  './data/maximumInputLength',
  './data/maximumSelectionLength',

  './dropdown',
  './dropdown/search',
  './dropdown/hidePlaceholder',
  './dropdown/infiniteScroll',
  './dropdown/attachBody',
  './dropdown/minimumResultsForSearch',
  './dropdown/selectOnClose',
  './dropdown/closeOnSelect',

  './i18n/en'
], function ($, require,

             ResultsList,

             SingleSelection, MultipleSelection, Placeholder, AllowClear,
             SelectionSearch, EventRelay,

             Utils, Translation, DIACRITICS,

             SelectData, ArrayData, AjaxData, Tags, Tokenizer,
             MinimumInputLength, MaximumInputLength, MaximumSelectionLength,

             Dropdown, DropdownSearch, HidePlaceholder, InfiniteScroll,
             AttachBody, MinimumResultsForSearch, SelectOnClose, CloseOnSelect,

             EnglishTranslation) {
  function Defaults () {
    this.reset();
  }

  Defaults.prototype.apply = function (options) {
    options = $.extend(true, {}, this.defaults, options);

    if (options.dataAdapter == null) {
      if (options.ajax != null) {
        options.dataAdapter = AjaxData;
      } else if (options.data != null) {
        options.dataAdapter = ArrayData;
      } else {
        options.dataAdapter = SelectData;
      }

      if (options.minimumInputLength > 0) {
        options.dataAdapter = Utils.Decorate(
          options.dataAdapter,
          MinimumInputLength
        );
      }

      if (options.maximumInputLength > 0) {
        options.dataAdapter = Utils.Decorate(
          options.dataAdapter,
          MaximumInputLength
        );
      }

      if (options.maximumSelectionLength > 0) {
        options.dataAdapter = Utils.Decorate(
          options.dataAdapter,
          MaximumSelectionLength
        );
      }

      if (options.tags) {
        options.dataAdapter = Utils.Decorate(options.dataAdapter, Tags);
      }

      if (options.tokenSeparators != null || options.tokenizer != null) {
        options.dataAdapter = Utils.Decorate(
          options.dataAdapter,
          Tokenizer
        );
      }

      if (options.query != null) {
        var Query = require(options.amdBase + 'compat/query');

        options.dataAdapter = Utils.Decorate(
          options.dataAdapter,
          Query
        );
      }

      if (options.initSelection != null) {
        var InitSelection = require(options.amdBase + 'compat/initSelection');

        options.dataAdapter = Utils.Decorate(
          options.dataAdapter,
          InitSelection
        );
      }
    }

    if (options.resultsAdapter == null) {
      options.resultsAdapter = ResultsList;

      if (options.ajax != null) {
        options.resultsAdapter = Utils.Decorate(
          options.resultsAdapter,
          InfiniteScroll
        );
      }

      if (options.placeholder != null) {
        options.resultsAdapter = Utils.Decorate(
          options.resultsAdapter,
          HidePlaceholder
        );
      }

      if (options.selectOnClose) {
        options.resultsAdapter = Utils.Decorate(
          options.resultsAdapter,
          SelectOnClose
        );
      }
    }

    if (options.dropdownAdapter == null) {
      if (options.multiple) {
        options.dropdownAdapter = Dropdown;
      } else {
        var SearchableDropdown = Utils.Decorate(Dropdown, DropdownSearch);

        options.dropdownAdapter = SearchableDropdown;
      }

      if (options.minimumResultsForSearch !== 0) {
        options.dropdownAdapter = Utils.Decorate(
          options.dropdownAdapter,
          MinimumResultsForSearch
        );
      }

      if (options.closeOnSelect) {
        options.dropdownAdapter = Utils.Decorate(
          options.dropdownAdapter,
          CloseOnSelect
        );
      }

      if (
        options.dropdownCssClass != null ||
        options.dropdownCss != null ||
        options.adaptDropdownCssClass != null
      ) {
        var DropdownCSS = require(options.amdBase + 'compat/dropdownCss');

        options.dropdownAdapter = Utils.Decorate(
          options.dropdownAdapter,
          DropdownCSS
        );
      }

      options.dropdownAdapter = Utils.Decorate(
        options.dropdownAdapter,
        AttachBody
      );
    }

    if (options.selectionAdapter == null) {
      if (options.multiple) {
        options.selectionAdapter = MultipleSelection;
      } else {
        options.selectionAdapter = SingleSelection;
      }

      // Add the placeholder mixin if a placeholder was specified
      if (options.placeholder != null) {
        options.selectionAdapter = Utils.Decorate(
          options.selectionAdapter,
          Placeholder
        );
      }

      if (options.allowClear) {
        options.selectionAdapter = Utils.Decorate(
          options.selectionAdapter,
          AllowClear
        );
      }

      if (options.multiple) {
        options.selectionAdapter = Utils.Decorate(
          options.selectionAdapter,
          SelectionSearch
        );
      }

      if (
        options.containerCssClass != null ||
        options.containerCss != null ||
        options.adaptContainerCssClass != null
      ) {
        var ContainerCSS = require(options.amdBase + 'compat/containerCss');

        options.selectionAdapter = Utils.Decorate(
          options.selectionAdapter,
          ContainerCSS
        );
      }

      options.selectionAdapter = Utils.Decorate(
        options.selectionAdapter,
        EventRelay
      );
    }

    if (typeof options.language === 'string') {
      // Check if the language is specified with a region
      if (options.language.indexOf('-') > 0) {
        // Extract the region information if it is included
        var languageParts = options.language.split('-');
        var baseLanguage = languageParts[0];

        options.language = [options.language, baseLanguage];
      } else {
        options.language = [options.language];
      }
    }

    if ($.isArray(options.language)) {
      var languages = new Translation();
      options.language.push('en');

      var languageNames = options.language;

      for (var l = 0; l < languageNames.length; l++) {
        var name = languageNames[l];
        var language = {};

        try {
          // Try to load it with the original name
          language = Translation.loadPath(name);
        } catch (e) {
          try {
            // If we couldn't load it, check if it wasn't the full path
            name = this.defaults.amdLanguageBase + name;
            language = Translation.loadPath(name);
          } catch (ex) {
            // The translation could not be loaded at all. Sometimes this is
            // because of a configuration problem, other times this can be
            // because of how Select2 helps load all possible translation files.
            if (options.debug && window.console && console.warn) {
              console.warn(
                'Select2: The language file for "' + name + '" could not be ' +
                'automatically loaded. A fallback will be used instead.'
              );
            }

            continue;
          }
        }

        languages.extend(language);
      }

      options.translations = languages;
    } else {
      var baseTranslation = Translation.loadPath(
        this.defaults.amdLanguageBase + 'en'
      );
      var customTranslation = new Translation(options.language);

      customTranslation.extend(baseTranslation);

      options.translations = customTranslation;
    }

    return options;
  };

  Defaults.prototype.reset = function () {
    function stripDiacritics (text) {
      // Used 'uni range + named function' from http://jsperf.com/diacritics/18
      function match(a) {
        return DIACRITICS[a] || a;
      }

      return text.replace(/[^\u0000-\u007E]/g, match);
    }

    function matcher (params, data) {
      // Always return the object if there is nothing to compare
      if ($.trim(params.term) === '') {
        return data;
      }

      // Do a recursive check for options with children
      if (data.children && data.children.length > 0) {
        // Clone the data object if there are children
        // This is required as we modify the object to remove any non-matches
        var match = $.extend(true, {}, data);

        // Check each child of the option
        for (var c = data.children.length - 1; c >= 0; c--) {
          var child = data.children[c];

          var matches = matcher(params, child);

          // If there wasn't a match, remove the object in the array
          if (matches == null) {
            match.children.splice(c, 1);
          }
        }

        // If any children matched, return the new object
        if (match.children.length > 0) {
          return match;
        }

        // If there were no matching children, check just the plain object
        return matcher(params, match);
      }

      var original = stripDiacritics(data.text).toUpperCase();
      var term = stripDiacritics(params.term).toUpperCase();

      // Check if the text contains the term
      if (original.indexOf(term) > -1) {
        return data;
      }

      // If it doesn't contain the term, don't return anything
      return null;
    }

    this.defaults = {
      amdBase: './',
      amdLanguageBase: './i18n/',
      closeOnSelect: true,
      debug: false,
      dropdownAutoWidth: false,
      escapeMarkup: Utils.escapeMarkup,
      language: EnglishTranslation,
      matcher: matcher,
      minimumInputLength: 0,
      maximumInputLength: 0,
      maximumSelectionLength: 0,
      minimumResultsForSearch: 0,
      selectOnClose: false,
      sorter: function (data) {
        return data;
      },
      templateResult: function (result) {
        return result.text;
      },
      templateSelection: function (selection) {
        return selection.text;
      },
      theme: 'default',
      width: 'resolve'
    };
  };

  Defaults.prototype.set = function (key, value) {
    var camelKey = $.camelCase(key);

    var data = {};
    data[camelKey] = value;

    var convertedData = Utils._convertData(data);

    $.extend(this.defaults, convertedData);
  };

  var defaults = new Defaults();

  return defaults;
});

S2.define('select2/options',[
  'require',
  'jquery',
  './defaults',
  './utils'
], function (require, $, Defaults, Utils) {
  function Options (options, $element) {
    this.options = options;

    if ($element != null) {
      this.fromElement($element);
    }

    this.options = Defaults.apply(this.options);

    if ($element && $element.is('input')) {
      var InputCompat = require(this.get('amdBase') + 'compat/inputData');

      this.options.dataAdapter = Utils.Decorate(
        this.options.dataAdapter,
        InputCompat
      );
    }
  }

  Options.prototype.fromElement = function ($e) {
    var excludedData = ['select2'];

    if (this.options.multiple == null) {
      this.options.multiple = $e.prop('multiple');
    }

    if (this.options.disabled == null) {
      this.options.disabled = $e.prop('disabled');
    }

    if (this.options.language == null) {
      if ($e.prop('lang')) {
        this.options.language = $e.prop('lang').toLowerCase();
      } else if ($e.closest('[lang]').prop('lang')) {
        this.options.language = $e.closest('[lang]').prop('lang');
      }
    }

    if (this.options.dir == null) {
      if ($e.prop('dir')) {
        this.options.dir = $e.prop('dir');
      } else if ($e.closest('[dir]').prop('dir')) {
        this.options.dir = $e.closest('[dir]').prop('dir');
      } else {
        this.options.dir = 'ltr';
      }
    }

    $e.prop('disabled', this.options.disabled);
    $e.prop('multiple', this.options.multiple);

    if ($e.data('select2Tags')) {
      if (this.options.debug && window.console && console.warn) {
        console.warn(
          'Select2: The `data-select2-tags` attribute has been changed to ' +
          'use the `data-data` and `data-tags="true"` attributes and will be ' +
          'removed in future versions of Select2.'
        );
      }

      $e.data('data', $e.data('select2Tags'));
      $e.data('tags', true);
    }

    if ($e.data('ajaxUrl')) {
      if (this.options.debug && window.console && console.warn) {
        console.warn(
          'Select2: The `data-ajax-url` attribute has been changed to ' +
          '`data-ajax--url` and support for the old attribute will be removed' +
          ' in future versions of Select2.'
        );
      }

      $e.attr('ajax--url', $e.data('ajaxUrl'));
      $e.data('ajax--url', $e.data('ajaxUrl'));
    }

    var dataset = {};

    // Prefer the element's `dataset` attribute if it exists
    // jQuery 1.x does not correctly handle data attributes with multiple dashes
    if ($.fn.jquery && $.fn.jquery.substr(0, 2) == '1.' && $e[0].dataset) {
      dataset = $.extend(true, {}, $e[0].dataset, $e.data());
    } else {
      dataset = $e.data();
    }

    var data = $.extend(true, {}, dataset);

    data = Utils._convertData(data);

    for (var key in data) {
      if ($.inArray(key, excludedData) > -1) {
        continue;
      }

      if ($.isPlainObject(this.options[key])) {
        $.extend(this.options[key], data[key]);
      } else {
        this.options[key] = data[key];
      }
    }

    return this;
  };

  Options.prototype.get = function (key) {
    return this.options[key];
  };

  Options.prototype.set = function (key, val) {
    this.options[key] = val;
  };

  return Options;
});

S2.define('select2/core',[
  'jquery',
  './options',
  './utils',
  './keys'
], function ($, Options, Utils, KEYS) {
  var Select2 = function ($element, options) {
    if ($element.data('select2') != null) {
      $element.data('select2').destroy();
    }

    this.$element = $element;

    this.id = this._generateId($element);

    options = options || {};

    this.options = new Options(options, $element);

    Select2.__super__.constructor.call(this);

    // Set up the tabindex

    var tabindex = $element.attr('tabindex') || 0;
    $element.data('old-tabindex', tabindex);
    $element.attr('tabindex', '-1');

    // Set up containers and adapters

    var DataAdapter = this.options.get('dataAdapter');
    this.dataAdapter = new DataAdapter($element, this.options);

    var $container = this.render();

    this._placeContainer($container);

    var SelectionAdapter = this.options.get('selectionAdapter');
    this.selection = new SelectionAdapter($element, this.options);
    this.$selection = this.selection.render();

    this.selection.position(this.$selection, $container);

    var DropdownAdapter = this.options.get('dropdownAdapter');
    this.dropdown = new DropdownAdapter($element, this.options);
    this.$dropdown = this.dropdown.render();

    this.dropdown.position(this.$dropdown, $container);

    var ResultsAdapter = this.options.get('resultsAdapter');
    this.results = new ResultsAdapter($element, this.options, this.dataAdapter);
    this.$results = this.results.render();

    this.results.position(this.$results, this.$dropdown);

    // Bind events

    var self = this;

    // Bind the container to all of the adapters
    this._bindAdapters();

    // Register any DOM event handlers
    this._registerDomEvents();

    // Register any internal event handlers
    this._registerDataEvents();
    this._registerSelectionEvents();
    this._registerDropdownEvents();
    this._registerResultsEvents();
    this._registerEvents();

    // Set the initial state
    this.dataAdapter.current(function (initialData) {
      self.trigger('selection:update', {
        data: initialData
      });
    });

    // Hide the original select
    $element.addClass('select2-hidden-accessible');
    $element.attr('aria-hidden', 'true');

    // Synchronize any monitored attributes
    this._syncAttributes();

    $element.data('select2', this);
  };

  Utils.Extend(Select2, Utils.Observable);

  Select2.prototype._generateId = function ($element) {
    var id = '';

    if ($element.attr('id') != null) {
      id = $element.attr('id');
    } else if ($element.attr('name') != null) {
      id = $element.attr('name') + '-' + Utils.generateChars(2);
    } else {
      id = Utils.generateChars(4);
    }

    id = id.replace(/(:|\.|\[|\]|,)/g, '');
    id = 'select2-' + id;

    return id;
  };

  Select2.prototype._placeContainer = function ($container) {
    $container.insertAfter(this.$element);

    var width = this._resolveWidth(this.$element, this.options.get('width'));

    if (width != null) {
      $container.css('width', width);
    }
  };

  Select2.prototype._resolveWidth = function ($element, method) {
    var WIDTH = /^width:(([-+]?([0-9]*\.)?[0-9]+)(px|em|ex|%|in|cm|mm|pt|pc))/i;

    if (method == 'resolve') {
      var styleWidth = this._resolveWidth($element, 'style');

      if (styleWidth != null) {
        return styleWidth;
      }

      return this._resolveWidth($element, 'element');
    }

    if (method == 'element') {
      var elementWidth = $element.outerWidth(false);

      if (elementWidth <= 0) {
        return 'auto';
      }

      return elementWidth + 'px';
    }

    if (method == 'style') {
      var style = $element.attr('style');

      if (typeof(style) !== 'string') {
        return null;
      }

      var attrs = style.split(';');

      for (var i = 0, l = attrs.length; i < l; i = i + 1) {
        var attr = attrs[i].replace(/\s/g, '');
        var matches = attr.match(WIDTH);

        if (matches !== null && matches.length >= 1) {
          return matches[1];
        }
      }

      return null;
    }

    return method;
  };

  Select2.prototype._bindAdapters = function () {
    this.dataAdapter.bind(this, this.$container);
    this.selection.bind(this, this.$container);

    this.dropdown.bind(this, this.$container);
    this.results.bind(this, this.$container);
  };

  Select2.prototype._registerDomEvents = function () {
    var self = this;

    this.$element.on('change.select2', function () {
      self.dataAdapter.current(function (data) {
        self.trigger('selection:update', {
          data: data
        });
      });
    });

    this.$element.on('focus.select2', function (evt) {
      self.trigger('focus', evt);
    });

    this._syncA = Utils.bind(this._syncAttributes, this);
    this._syncS = Utils.bind(this._syncSubtree, this);

    if (this.$element[0].attachEvent) {
      this.$element[0].attachEvent('onpropertychange', this._syncA);
    }

    var observer = window.MutationObserver ||
      window.WebKitMutationObserver ||
      window.MozMutationObserver
    ;

    if (observer != null) {
      this._observer = new observer(function (mutations) {
        $.each(mutations, self._syncA);
        $.each(mutations, self._syncS);
      });
      this._observer.observe(this.$element[0], {
        attributes: true,
        childList: true,
        subtree: false
      });
    } else if (this.$element[0].addEventListener) {
      this.$element[0].addEventListener(
        'DOMAttrModified',
        self._syncA,
        false
      );
      this.$element[0].addEventListener(
        'DOMNodeInserted',
        self._syncS,
        false
      );
      this.$element[0].addEventListener(
        'DOMNodeRemoved',
        self._syncS,
        false
      );
    }
  };

  Select2.prototype._registerDataEvents = function () {
    var self = this;

    this.dataAdapter.on('*', function (name, params) {
      self.trigger(name, params);
    });
  };

  Select2.prototype._registerSelectionEvents = function () {
    var self = this;
    var nonRelayEvents = ['toggle', 'focus'];

    this.selection.on('toggle', function () {
      self.toggleDropdown();
    });

    this.selection.on('focus', function (params) {
      self.focus(params);
    });

    this.selection.on('*', function (name, params) {
      if ($.inArray(name, nonRelayEvents) !== -1) {
        return;
      }

      self.trigger(name, params);
    });
  };

  Select2.prototype._registerDropdownEvents = function () {
    var self = this;

    this.dropdown.on('*', function (name, params) {
      self.trigger(name, params);
    });
  };

  Select2.prototype._registerResultsEvents = function () {
    var self = this;

    this.results.on('*', function (name, params) {
      self.trigger(name, params);
    });
  };

  Select2.prototype._registerEvents = function () {
    var self = this;

    this.on('open', function () {
      self.$container.addClass('select2-container--open');
    });

    this.on('close', function () {
      self.$container.removeClass('select2-container--open');
    });

    this.on('enable', function () {
      self.$container.removeClass('select2-container--disabled');
    });

    this.on('disable', function () {
      self.$container.addClass('select2-container--disabled');
    });

    this.on('blur', function () {
      self.$container.removeClass('select2-container--focus');
    });

    this.on('query', function (params) {
      if (!self.isOpen()) {
        self.trigger('open', {});
      }

      this.dataAdapter.query(params, function (data) {
        self.trigger('results:all', {
          data: data,
          query: params
        });
      });
    });

    this.on('query:append', function (params) {
      this.dataAdapter.query(params, function (data) {
        self.trigger('results:append', {
          data: data,
          query: params
        });
      });
    });

    this.on('keypress', function (evt) {
      var key = evt.which;

      if (self.isOpen()) {
        if (key === KEYS.ESC || key === KEYS.TAB ||
            (key === KEYS.UP && evt.altKey)) {
          self.close();

          evt.preventDefault();
        } else if (key === KEYS.ENTER) {
          self.trigger('results:select', {});

          evt.preventDefault();
        } else if ((key === KEYS.SPACE && evt.ctrlKey)) {
          self.trigger('results:toggle', {});

          evt.preventDefault();
        } else if (key === KEYS.UP) {
          self.trigger('results:previous', {});

          evt.preventDefault();
        } else if (key === KEYS.DOWN) {
          self.trigger('results:next', {});

          evt.preventDefault();
        }
      } else {
        if (key === KEYS.ENTER || key === KEYS.SPACE ||
            (key === KEYS.DOWN && evt.altKey)) {
          self.open();

          evt.preventDefault();
        }
      }
    });
  };

  Select2.prototype._syncAttributes = function () {
    this.options.set('disabled', this.$element.prop('disabled'));

    if (this.options.get('disabled')) {
      if (this.isOpen()) {
        this.close();
      }

      this.trigger('disable', {});
    } else {
      this.trigger('enable', {});
    }
  };

  Select2.prototype._syncSubtree = function (evt, mutations) {
    var changed = false;
    var self = this;

    // Ignore any mutation events raised for elements that aren't options or
    // optgroups. This handles the case when the select element is destroyed
    if (
      evt && evt.target && (
        evt.target.nodeName !== 'OPTION' && evt.target.nodeName !== 'OPTGROUP'
      )
    ) {
      return;
    }

    if (!mutations) {
      // If mutation events aren't supported, then we can only assume that the
      // change affected the selections
      changed = true;
    } else if (mutations.addedNodes && mutations.addedNodes.length > 0) {
      for (var n = 0; n < mutations.addedNodes.length; n++) {
        var node = mutations.addedNodes[n];

        if (node.selected) {
          changed = true;
        }
      }
    } else if (mutations.removedNodes && mutations.removedNodes.length > 0) {
      changed = true;
    }

    // Only re-pull the data if we think there is a change
    if (changed) {
      this.dataAdapter.current(function (currentData) {
        self.trigger('selection:update', {
          data: currentData
        });
      });
    }
  };

  /**
   * Override the trigger method to automatically trigger pre-events when
   * there are events that can be prevented.
   */
  Select2.prototype.trigger = function (name, args) {
    var actualTrigger = Select2.__super__.trigger;
    var preTriggerMap = {
      'open': 'opening',
      'close': 'closing',
      'select': 'selecting',
      'unselect': 'unselecting'
    };

    if (args === undefined) {
      args = {};
    }

    if (name in preTriggerMap) {
      var preTriggerName = preTriggerMap[name];
      var preTriggerArgs = {
        prevented: false,
        name: name,
        args: args
      };

      actualTrigger.call(this, preTriggerName, preTriggerArgs);

      if (preTriggerArgs.prevented) {
        args.prevented = true;

        return;
      }
    }

    actualTrigger.call(this, name, args);
  };

  Select2.prototype.toggleDropdown = function () {
    if (this.options.get('disabled')) {
      return;
    }

    if (this.isOpen()) {
      this.close();
    } else {
      this.open();
    }
  };

  Select2.prototype.open = function () {
    if (this.isOpen()) {
      return;
    }

    this.trigger('query', {});
  };

  Select2.prototype.close = function () {
    if (!this.isOpen()) {
      return;
    }

    this.trigger('close', {});
  };

  Select2.prototype.isOpen = function () {
    return this.$container.hasClass('select2-container--open');
  };

  Select2.prototype.hasFocus = function () {
    return this.$container.hasClass('select2-container--focus');
  };

  Select2.prototype.focus = function (data) {
    // No need to re-trigger focus events if we are already focused
    if (this.hasFocus()) {
      return;
    }

    this.$container.addClass('select2-container--focus');
    this.trigger('focus', {});
  };

  Select2.prototype.enable = function (args) {
    if (this.options.get('debug') && window.console && console.warn) {
      console.warn(
        'Select2: The `select2("enable")` method has been deprecated and will' +
        ' be removed in later Select2 versions. Use $element.prop("disabled")' +
        ' instead.'
      );
    }

    if (args == null || args.length === 0) {
      args = [true];
    }

    var disabled = !args[0];

    this.$element.prop('disabled', disabled);
  };

  Select2.prototype.data = function () {
    if (this.options.get('debug') &&
        arguments.length > 0 && window.console && console.warn) {
      console.warn(
        'Select2: Data can no longer be set using `select2("data")`. You ' +
        'should consider setting the value instead using `$element.val()`.'
      );
    }

    var data = [];

    this.dataAdapter.current(function (currentData) {
      data = currentData;
    });

    return data;
  };

  Select2.prototype.val = function (args) {
    if (this.options.get('debug') && window.console && console.warn) {
      console.warn(
        'Select2: The `select2("val")` method has been deprecated and will be' +
        ' removed in later Select2 versions. Use $element.val() instead.'
      );
    }

    if (args == null || args.length === 0) {
      return this.$element.val();
    }

    var newVal = args[0];

    if ($.isArray(newVal)) {
      newVal = $.map(newVal, function (obj) {
        return obj.toString();
      });
    }

    this.$element.val(newVal).trigger('change');
  };

  Select2.prototype.destroy = function () {
    this.$container.remove();

    if (this.$element[0].detachEvent) {
      this.$element[0].detachEvent('onpropertychange', this._syncA);
    }

    if (this._observer != null) {
      this._observer.disconnect();
      this._observer = null;
    } else if (this.$element[0].removeEventListener) {
      this.$element[0]
        .removeEventListener('DOMAttrModified', this._syncA, false);
      this.$element[0]
        .removeEventListener('DOMNodeInserted', this._syncS, false);
      this.$element[0]
        .removeEventListener('DOMNodeRemoved', this._syncS, false);
    }

    this._syncA = null;
    this._syncS = null;

    this.$element.off('.select2');
    this.$element.attr('tabindex', this.$element.data('old-tabindex'));

    this.$element.removeClass('select2-hidden-accessible');
    this.$element.attr('aria-hidden', 'false');
    this.$element.removeData('select2');

    this.dataAdapter.destroy();
    this.selection.destroy();
    this.dropdown.destroy();
    this.results.destroy();

    this.dataAdapter = null;
    this.selection = null;
    this.dropdown = null;
    this.results = null;
  };

  Select2.prototype.render = function () {
    var $container = $(
      '<span class="select2 select2-container">' +
        '<span class="selection"></span>' +
        '<span class="dropdown-wrapper" aria-hidden="true"></span>' +
      '</span>'
    );

    $container.attr('dir', this.options.get('dir'));

    this.$container = $container;

    this.$container.addClass('select2-container--' + this.options.get('theme'));

    $container.data('element', this.$element);

    return $container;
  };

  return Select2;
});

S2.define('jquery-mousewheel',[
  'jquery'
], function ($) {
  // Used to shim jQuery.mousewheel for non-full builds.
  return $;
});

S2.define('jquery.select2',[
  'jquery',
  'jquery-mousewheel',

  './select2/core',
  './select2/defaults'
], function ($, _, Select2, Defaults) {
  if ($.fn.select2 == null) {
    // All methods that should return the element
    var thisMethods = ['open', 'close', 'destroy'];

    $.fn.select2 = function (options) {
      options = options || {};

      if (typeof options === 'object') {
        this.each(function () {
          var instanceOptions = $.extend(true, {}, options);

          var instance = new Select2($(this), instanceOptions);
        });

        return this;
      } else if (typeof options === 'string') {
        var ret;
        var args = Array.prototype.slice.call(arguments, 1);

        this.each(function () {
          var instance = $(this).data('select2');

          if (instance == null && window.console && console.error) {
            console.error(
              'The select2(\'' + options + '\') method was called on an ' +
              'element that is not using Select2.'
            );
          }

          ret = instance[options].apply(instance, args);
        });

        // Check if we should be returning `this`
        if ($.inArray(options, thisMethods) > -1) {
          return this;
        }

        return ret;
      } else {
        throw new Error('Invalid arguments for Select2: ' + options);
      }
    };
  }

  if ($.fn.select2.defaults == null) {
    $.fn.select2.defaults = Defaults;
  }

  return Select2;
});

  // Return the AMD loader configuration so it can be used outside of this file
  return {
    define: S2.define,
    require: S2.require
  };
}());

  // Autoload the jQuery bindings
  // We know that all of the modules exist above this, so we're safe
  var select2 = S2.require('jquery.select2');

  // Hold the AMD module references on the jQuery function that was just loaded
  // This allows Select2 to use the internal loader outside of this file, such
  // as in the language files.
  jQuery.fn.select2.amd = S2;

  // Return the Select2 instance for anyone who is importing it.
  return select2;
}));
/*
 * Chained - jQuery / Zepto chained selects plugin
 *
 * Copyright (c) 2010-2014 Mika Tuupola
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Project home:
 *   http://www.appelsiini.net/projects/chained
 *
 * Version: 0.9.10
 *
 */


;(function($, window, document, undefined) {
    "use strict";

    $.fn.chained = function(parent_selector, options) {

        return this.each(function() {

            /* Save this to child because this changes when scope changes. */
            var child   = this;
            var backup = $(child).clone();

            /* Handles maximum two parents now. */
            $(parent_selector).each(function() {
                $(this).bind("change", function() {
                    updateChildren();
                });

                /* Force IE to see something selected on first page load, */
                /* unless something is already selected */
                if (!$("option:selected", this).length) {
                    $("option", this).first().attr("selected", "selected");
                }

                /* Force updating the children. */
                updateChildren();
            });

            function updateChildren() {
                var trigger_change = true;
                var currently_selected_value = $("option:selected", child).val();

                $(child).html(backup.html());

                /* If multiple parents build classname like foo\bar. */
                var selected = "";
                $(parent_selector).each(function() {
                    var selectedClass = $("option:selected", this).val();
                    if (selectedClass) {
                        if (selected.length > 0) {
                            if (window.Zepto) {
                                /* Zepto class regexp dies with classes like foo\bar. */
                                selected += "\\\\";
                            } else {
                                selected += "\\";
                            }
                        }
                        selected += selectedClass;
                    }
                });

                /* Also check for first parent without subclassing. */
                /* TODO: This should be dynamic and check for each parent */
                /*       without subclassing. */
                var first;
                if ($.isArray(parent_selector)) {
                    first = $(parent_selector[0]).first();
                } else {
                    first = $(parent_selector).first();
                }
                var selected_first = $("option:selected", first).val();

                $("option", child).each(function() {
                    /* Remove unneeded items but save the default value. */
                    if ($(this).hasClass(selected) && $(this).val() === currently_selected_value) {
                        $(this).prop("selected", true);
                        trigger_change = false;
                    } else if (!$(this).hasClass(selected) && !$(this).hasClass(selected_first) && $(this).val() !== "") {
                        $(this).remove();
                    }
                });

                /* If we have only the default value disable select. */
                if (1 === $("option", child).size() && $(child).val() === "") {
                    $(child).prop("disabled", true);
                } else {
                    $(child).prop("disabled", false);
                }
                if (trigger_change) {
                    $(child).trigger("change");
                }
            }
        });
    };

    /* Alias for those who like to use more English like syntax. */
    $.fn.chainedTo = $.fn.chained;

    /* Default settings for plugin. */
    $.fn.chained.defaults = {};

})(window.jQuery || window.Zepto, window, document);
/*
 * File:        jquery.dataTables.min.js
 * Version:     1.9.4
 * Author:      Allan Jardine (www.sprymedia.co.uk)
 * Info:        www.datatables.net
 * 
 * Copyright 2008-2012 Allan Jardine, all rights reserved.
 *
 * This source file is free software, under either the GPL v2 license or a
 * BSD style license, available at:
 *   http://datatables.net/license_gpl2
 *   http://datatables.net/license_bsd
 * 
 * This source file is distributed in the hope that it will be useful, but 
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
 * or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.
 */

(function(X,l,n){var L=function(h){var j=function(e){function o(a,b){var c=j.defaults.columns,d=a.aoColumns.length,c=h.extend({},j.models.oColumn,c,{sSortingClass:a.oClasses.sSortable,sSortingClassJUI:a.oClasses.sSortJUI,nTh:b?b:l.createElement("th"),sTitle:c.sTitle?c.sTitle:b?b.innerHTML:"",aDataSort:c.aDataSort?c.aDataSort:[d],mData:c.mData?c.oDefaults:d});a.aoColumns.push(c);if(a.aoPreSearchCols[d]===n||null===a.aoPreSearchCols[d])a.aoPreSearchCols[d]=h.extend({},j.models.oSearch);else if(c=a.aoPreSearchCols[d],
c.bRegex===n&&(c.bRegex=!0),c.bSmart===n&&(c.bSmart=!0),c.bCaseInsensitive===n)c.bCaseInsensitive=!0;m(a,d,null)}function m(a,b,c){var d=a.aoColumns[b];c!==n&&null!==c&&(c.mDataProp&&!c.mData&&(c.mData=c.mDataProp),c.sType!==n&&(d.sType=c.sType,d._bAutoType=!1),h.extend(d,c),p(d,c,"sWidth","sWidthOrig"),c.iDataSort!==n&&(d.aDataSort=[c.iDataSort]),p(d,c,"aDataSort"));var i=d.mRender?Q(d.mRender):null,f=Q(d.mData);d.fnGetData=function(a,b){var c=f(a,b);return d.mRender&&b&&""!==b?i(c,b,a):c};d.fnSetData=
L(d.mData);a.oFeatures.bSort||(d.bSortable=!1);!d.bSortable||-1==h.inArray("asc",d.asSorting)&&-1==h.inArray("desc",d.asSorting)?(d.sSortingClass=a.oClasses.sSortableNone,d.sSortingClassJUI=""):-1==h.inArray("asc",d.asSorting)&&-1==h.inArray("desc",d.asSorting)?(d.sSortingClass=a.oClasses.sSortable,d.sSortingClassJUI=a.oClasses.sSortJUI):-1!=h.inArray("asc",d.asSorting)&&-1==h.inArray("desc",d.asSorting)?(d.sSortingClass=a.oClasses.sSortableAsc,d.sSortingClassJUI=a.oClasses.sSortJUIAscAllowed):-1==
h.inArray("asc",d.asSorting)&&-1!=h.inArray("desc",d.asSorting)&&(d.sSortingClass=a.oClasses.sSortableDesc,d.sSortingClassJUI=a.oClasses.sSortJUIDescAllowed)}function k(a){if(!1===a.oFeatures.bAutoWidth)return!1;da(a);for(var b=0,c=a.aoColumns.length;b<c;b++)a.aoColumns[b].nTh.style.width=a.aoColumns[b].sWidth}function G(a,b){var c=r(a,"bVisible");return"number"===typeof c[b]?c[b]:null}function R(a,b){var c=r(a,"bVisible"),c=h.inArray(b,c);return-1!==c?c:null}function t(a){return r(a,"bVisible").length}
function r(a,b){var c=[];h.map(a.aoColumns,function(a,i){a[b]&&c.push(i)});return c}function B(a){for(var b=j.ext.aTypes,c=b.length,d=0;d<c;d++){var i=b[d](a);if(null!==i)return i}return"string"}function u(a,b){for(var c=b.split(","),d=[],i=0,f=a.aoColumns.length;i<f;i++)for(var g=0;g<f;g++)if(a.aoColumns[i].sName==c[g]){d.push(g);break}return d}function M(a){for(var b="",c=0,d=a.aoColumns.length;c<d;c++)b+=a.aoColumns[c].sName+",";return b.length==d?"":b.slice(0,-1)}function ta(a,b,c,d){var i,f,
g,e,w;if(b)for(i=b.length-1;0<=i;i--){var j=b[i].aTargets;h.isArray(j)||D(a,1,"aTargets must be an array of targets, not a "+typeof j);f=0;for(g=j.length;f<g;f++)if("number"===typeof j[f]&&0<=j[f]){for(;a.aoColumns.length<=j[f];)o(a);d(j[f],b[i])}else if("number"===typeof j[f]&&0>j[f])d(a.aoColumns.length+j[f],b[i]);else if("string"===typeof j[f]){e=0;for(w=a.aoColumns.length;e<w;e++)("_all"==j[f]||h(a.aoColumns[e].nTh).hasClass(j[f]))&&d(e,b[i])}}if(c){i=0;for(a=c.length;i<a;i++)d(i,c[i])}}function H(a,
b){var c;c=h.isArray(b)?b.slice():h.extend(!0,{},b);var d=a.aoData.length,i=h.extend(!0,{},j.models.oRow);i._aData=c;a.aoData.push(i);for(var f,i=0,g=a.aoColumns.length;i<g;i++)c=a.aoColumns[i],"function"===typeof c.fnRender&&c.bUseRendered&&null!==c.mData?F(a,d,i,S(a,d,i)):F(a,d,i,v(a,d,i)),c._bAutoType&&"string"!=c.sType&&(f=v(a,d,i,"type"),null!==f&&""!==f&&(f=B(f),null===c.sType?c.sType=f:c.sType!=f&&"html"!=c.sType&&(c.sType="string")));a.aiDisplayMaster.push(d);a.oFeatures.bDeferRender||ea(a,
d);return d}function ua(a){var b,c,d,i,f,g,e;if(a.bDeferLoading||null===a.sAjaxSource)for(b=a.nTBody.firstChild;b;){if("TR"==b.nodeName.toUpperCase()){c=a.aoData.length;b._DT_RowIndex=c;a.aoData.push(h.extend(!0,{},j.models.oRow,{nTr:b}));a.aiDisplayMaster.push(c);f=b.firstChild;for(d=0;f;){g=f.nodeName.toUpperCase();if("TD"==g||"TH"==g)F(a,c,d,h.trim(f.innerHTML)),d++;f=f.nextSibling}}b=b.nextSibling}i=T(a);d=[];b=0;for(c=i.length;b<c;b++)for(f=i[b].firstChild;f;)g=f.nodeName.toUpperCase(),("TD"==
g||"TH"==g)&&d.push(f),f=f.nextSibling;c=0;for(i=a.aoColumns.length;c<i;c++){e=a.aoColumns[c];null===e.sTitle&&(e.sTitle=e.nTh.innerHTML);var w=e._bAutoType,o="function"===typeof e.fnRender,k=null!==e.sClass,n=e.bVisible,m,p;if(w||o||k||!n){g=0;for(b=a.aoData.length;g<b;g++)f=a.aoData[g],m=d[g*i+c],w&&"string"!=e.sType&&(p=v(a,g,c,"type"),""!==p&&(p=B(p),null===e.sType?e.sType=p:e.sType!=p&&"html"!=e.sType&&(e.sType="string"))),e.mRender?m.innerHTML=v(a,g,c,"display"):e.mData!==c&&(m.innerHTML=v(a,
g,c,"display")),o&&(p=S(a,g,c),m.innerHTML=p,e.bUseRendered&&F(a,g,c,p)),k&&(m.className+=" "+e.sClass),n?f._anHidden[c]=null:(f._anHidden[c]=m,m.parentNode.removeChild(m)),e.fnCreatedCell&&e.fnCreatedCell.call(a.oInstance,m,v(a,g,c,"display"),f._aData,g,c)}}if(0!==a.aoRowCreatedCallback.length){b=0;for(c=a.aoData.length;b<c;b++)f=a.aoData[b],A(a,"aoRowCreatedCallback",null,[f.nTr,f._aData,b])}}function I(a,b){return b._DT_RowIndex!==n?b._DT_RowIndex:null}function fa(a,b,c){for(var b=J(a,b),d=0,a=
a.aoColumns.length;d<a;d++)if(b[d]===c)return d;return-1}function Y(a,b,c,d){for(var i=[],f=0,g=d.length;f<g;f++)i.push(v(a,b,d[f],c));return i}function v(a,b,c,d){var i=a.aoColumns[c];if((c=i.fnGetData(a.aoData[b]._aData,d))===n)return a.iDrawError!=a.iDraw&&null===i.sDefaultContent&&(D(a,0,"Requested unknown parameter "+("function"==typeof i.mData?"{mData function}":"'"+i.mData+"'")+" from the data source for row "+b),a.iDrawError=a.iDraw),i.sDefaultContent;if(null===c&&null!==i.sDefaultContent)c=
i.sDefaultContent;else if("function"===typeof c)return c();return"display"==d&&null===c?"":c}function F(a,b,c,d){a.aoColumns[c].fnSetData(a.aoData[b]._aData,d)}function Q(a){if(null===a)return function(){return null};if("function"===typeof a)return function(b,d,i){return a(b,d,i)};if("string"===typeof a&&(-1!==a.indexOf(".")||-1!==a.indexOf("["))){var b=function(a,d,i){var f=i.split("."),g;if(""!==i){var e=0;for(g=f.length;e<g;e++){if(i=f[e].match(U)){f[e]=f[e].replace(U,"");""!==f[e]&&(a=a[f[e]]);
g=[];f.splice(0,e+1);for(var f=f.join("."),e=0,h=a.length;e<h;e++)g.push(b(a[e],d,f));a=i[0].substring(1,i[0].length-1);a=""===a?g:g.join(a);break}if(null===a||a[f[e]]===n)return n;a=a[f[e]]}}return a};return function(c,d){return b(c,d,a)}}return function(b){return b[a]}}function L(a){if(null===a)return function(){};if("function"===typeof a)return function(b,d){a(b,"set",d)};if("string"===typeof a&&(-1!==a.indexOf(".")||-1!==a.indexOf("["))){var b=function(a,d,i){var i=i.split("."),f,g,e=0;for(g=
i.length-1;e<g;e++){if(f=i[e].match(U)){i[e]=i[e].replace(U,"");a[i[e]]=[];f=i.slice();f.splice(0,e+1);g=f.join(".");for(var h=0,j=d.length;h<j;h++)f={},b(f,d[h],g),a[i[e]].push(f);return}if(null===a[i[e]]||a[i[e]]===n)a[i[e]]={};a=a[i[e]]}a[i[i.length-1].replace(U,"")]=d};return function(c,d){return b(c,d,a)}}return function(b,d){b[a]=d}}function Z(a){for(var b=[],c=a.aoData.length,d=0;d<c;d++)b.push(a.aoData[d]._aData);return b}function ga(a){a.aoData.splice(0,a.aoData.length);a.aiDisplayMaster.splice(0,
a.aiDisplayMaster.length);a.aiDisplay.splice(0,a.aiDisplay.length);y(a)}function ha(a,b){for(var c=-1,d=0,i=a.length;d<i;d++)a[d]==b?c=d:a[d]>b&&a[d]--; -1!=c&&a.splice(c,1)}function S(a,b,c){var d=a.aoColumns[c];return d.fnRender({iDataRow:b,iDataColumn:c,oSettings:a,aData:a.aoData[b]._aData,mDataProp:d.mData},v(a,b,c,"display"))}function ea(a,b){var c=a.aoData[b],d;if(null===c.nTr){c.nTr=l.createElement("tr");c.nTr._DT_RowIndex=b;c._aData.DT_RowId&&(c.nTr.id=c._aData.DT_RowId);c._aData.DT_RowClass&&
(c.nTr.className=c._aData.DT_RowClass);for(var i=0,f=a.aoColumns.length;i<f;i++){var g=a.aoColumns[i];d=l.createElement(g.sCellType);d.innerHTML="function"===typeof g.fnRender&&(!g.bUseRendered||null===g.mData)?S(a,b,i):v(a,b,i,"display");null!==g.sClass&&(d.className=g.sClass);g.bVisible?(c.nTr.appendChild(d),c._anHidden[i]=null):c._anHidden[i]=d;g.fnCreatedCell&&g.fnCreatedCell.call(a.oInstance,d,v(a,b,i,"display"),c._aData,b,i)}A(a,"aoRowCreatedCallback",null,[c.nTr,c._aData,b])}}function va(a){var b,
c,d;if(0!==h("th, td",a.nTHead).length){b=0;for(d=a.aoColumns.length;b<d;b++)if(c=a.aoColumns[b].nTh,c.setAttribute("role","columnheader"),a.aoColumns[b].bSortable&&(c.setAttribute("tabindex",a.iTabIndex),c.setAttribute("aria-controls",a.sTableId)),null!==a.aoColumns[b].sClass&&h(c).addClass(a.aoColumns[b].sClass),a.aoColumns[b].sTitle!=c.innerHTML)c.innerHTML=a.aoColumns[b].sTitle}else{var i=l.createElement("tr");b=0;for(d=a.aoColumns.length;b<d;b++)c=a.aoColumns[b].nTh,c.innerHTML=a.aoColumns[b].sTitle,
c.setAttribute("tabindex","0"),null!==a.aoColumns[b].sClass&&h(c).addClass(a.aoColumns[b].sClass),i.appendChild(c);h(a.nTHead).html("")[0].appendChild(i);V(a.aoHeader,a.nTHead)}h(a.nTHead).children("tr").attr("role","row");if(a.bJUI){b=0;for(d=a.aoColumns.length;b<d;b++){c=a.aoColumns[b].nTh;i=l.createElement("div");i.className=a.oClasses.sSortJUIWrapper;h(c).contents().appendTo(i);var f=l.createElement("span");f.className=a.oClasses.sSortIcon;i.appendChild(f);c.appendChild(i)}}if(a.oFeatures.bSort)for(b=
0;b<a.aoColumns.length;b++)!1!==a.aoColumns[b].bSortable?ia(a,a.aoColumns[b].nTh,b):h(a.aoColumns[b].nTh).addClass(a.oClasses.sSortableNone);""!==a.oClasses.sFooterTH&&h(a.nTFoot).children("tr").children("th").addClass(a.oClasses.sFooterTH);if(null!==a.nTFoot){c=N(a,null,a.aoFooter);b=0;for(d=a.aoColumns.length;b<d;b++)c[b]&&(a.aoColumns[b].nTf=c[b],a.aoColumns[b].sClass&&h(c[b]).addClass(a.aoColumns[b].sClass))}}function W(a,b,c){var d,i,f,g=[],e=[],h=a.aoColumns.length,j;c===n&&(c=!1);d=0;for(i=
b.length;d<i;d++){g[d]=b[d].slice();g[d].nTr=b[d].nTr;for(f=h-1;0<=f;f--)!a.aoColumns[f].bVisible&&!c&&g[d].splice(f,1);e.push([])}d=0;for(i=g.length;d<i;d++){if(a=g[d].nTr)for(;f=a.firstChild;)a.removeChild(f);f=0;for(b=g[d].length;f<b;f++)if(j=h=1,e[d][f]===n){a.appendChild(g[d][f].cell);for(e[d][f]=1;g[d+h]!==n&&g[d][f].cell==g[d+h][f].cell;)e[d+h][f]=1,h++;for(;g[d][f+j]!==n&&g[d][f].cell==g[d][f+j].cell;){for(c=0;c<h;c++)e[d+c][f+j]=1;j++}g[d][f].cell.rowSpan=h;g[d][f].cell.colSpan=j}}}function x(a){var b=
A(a,"aoPreDrawCallback","preDraw",[a]);if(-1!==h.inArray(!1,b))E(a,!1);else{var c,d,b=[],i=0,f=a.asStripeClasses.length;c=a.aoOpenRows.length;a.bDrawing=!0;a.iInitDisplayStart!==n&&-1!=a.iInitDisplayStart&&(a._iDisplayStart=a.oFeatures.bServerSide?a.iInitDisplayStart:a.iInitDisplayStart>=a.fnRecordsDisplay()?0:a.iInitDisplayStart,a.iInitDisplayStart=-1,y(a));if(a.bDeferLoading)a.bDeferLoading=!1,a.iDraw++;else if(a.oFeatures.bServerSide){if(!a.bDestroying&&!wa(a))return}else a.iDraw++;if(0!==a.aiDisplay.length){var g=
a._iDisplayStart;d=a._iDisplayEnd;a.oFeatures.bServerSide&&(g=0,d=a.aoData.length);for(;g<d;g++){var e=a.aoData[a.aiDisplay[g]];null===e.nTr&&ea(a,a.aiDisplay[g]);var j=e.nTr;if(0!==f){var o=a.asStripeClasses[i%f];e._sRowStripe!=o&&(h(j).removeClass(e._sRowStripe).addClass(o),e._sRowStripe=o)}A(a,"aoRowCallback",null,[j,a.aoData[a.aiDisplay[g]]._aData,i,g]);b.push(j);i++;if(0!==c)for(e=0;e<c;e++)if(j==a.aoOpenRows[e].nParent){b.push(a.aoOpenRows[e].nTr);break}}}else b[0]=l.createElement("tr"),a.asStripeClasses[0]&&
(b[0].className=a.asStripeClasses[0]),c=a.oLanguage,f=c.sZeroRecords,1==a.iDraw&&null!==a.sAjaxSource&&!a.oFeatures.bServerSide?f=c.sLoadingRecords:c.sEmptyTable&&0===a.fnRecordsTotal()&&(f=c.sEmptyTable),c=l.createElement("td"),c.setAttribute("valign","top"),c.colSpan=t(a),c.className=a.oClasses.sRowEmpty,c.innerHTML=ja(a,f),b[i].appendChild(c);A(a,"aoHeaderCallback","header",[h(a.nTHead).children("tr")[0],Z(a),a._iDisplayStart,a.fnDisplayEnd(),a.aiDisplay]);A(a,"aoFooterCallback","footer",[h(a.nTFoot).children("tr")[0],
Z(a),a._iDisplayStart,a.fnDisplayEnd(),a.aiDisplay]);i=l.createDocumentFragment();c=l.createDocumentFragment();if(a.nTBody){f=a.nTBody.parentNode;c.appendChild(a.nTBody);if(!a.oScroll.bInfinite||!a._bInitComplete||a.bSorted||a.bFiltered)for(;c=a.nTBody.firstChild;)a.nTBody.removeChild(c);c=0;for(d=b.length;c<d;c++)i.appendChild(b[c]);a.nTBody.appendChild(i);null!==f&&f.appendChild(a.nTBody)}A(a,"aoDrawCallback","draw",[a]);a.bSorted=!1;a.bFiltered=!1;a.bDrawing=!1;a.oFeatures.bServerSide&&(E(a,!1),
a._bInitComplete||$(a))}}function aa(a){a.oFeatures.bSort?O(a,a.oPreviousSearch):a.oFeatures.bFilter?K(a,a.oPreviousSearch):(y(a),x(a))}function xa(a){var b=h("<div></div>")[0];a.nTable.parentNode.insertBefore(b,a.nTable);a.nTableWrapper=h('<div id="'+a.sTableId+'_wrapper" class="'+a.oClasses.sWrapper+'" role="grid"></div>')[0];a.nTableReinsertBefore=a.nTable.nextSibling;for(var c=a.nTableWrapper,d=a.sDom.split(""),i,f,g,e,w,o,k,m=0;m<d.length;m++){f=0;g=d[m];if("<"==g){e=h("<div></div>")[0];w=d[m+
1];if("'"==w||'"'==w){o="";for(k=2;d[m+k]!=w;)o+=d[m+k],k++;"H"==o?o=a.oClasses.sJUIHeader:"F"==o&&(o=a.oClasses.sJUIFooter);-1!=o.indexOf(".")?(w=o.split("."),e.id=w[0].substr(1,w[0].length-1),e.className=w[1]):"#"==o.charAt(0)?e.id=o.substr(1,o.length-1):e.className=o;m+=k}c.appendChild(e);c=e}else if(">"==g)c=c.parentNode;else if("l"==g&&a.oFeatures.bPaginate&&a.oFeatures.bLengthChange)i=ya(a),f=1;else if("f"==g&&a.oFeatures.bFilter)i=za(a),f=1;else if("r"==g&&a.oFeatures.bProcessing)i=Aa(a),f=
1;else if("t"==g)i=Ba(a),f=1;else if("i"==g&&a.oFeatures.bInfo)i=Ca(a),f=1;else if("p"==g&&a.oFeatures.bPaginate)i=Da(a),f=1;else if(0!==j.ext.aoFeatures.length){e=j.ext.aoFeatures;k=0;for(w=e.length;k<w;k++)if(g==e[k].cFeature){(i=e[k].fnInit(a))&&(f=1);break}}1==f&&null!==i&&("object"!==typeof a.aanFeatures[g]&&(a.aanFeatures[g]=[]),a.aanFeatures[g].push(i),c.appendChild(i))}b.parentNode.replaceChild(a.nTableWrapper,b)}function V(a,b){var c=h(b).children("tr"),d,i,f,g,e,j,o,k,m,p;a.splice(0,a.length);
f=0;for(j=c.length;f<j;f++)a.push([]);f=0;for(j=c.length;f<j;f++){d=c[f];for(i=d.firstChild;i;){if("TD"==i.nodeName.toUpperCase()||"TH"==i.nodeName.toUpperCase()){k=1*i.getAttribute("colspan");m=1*i.getAttribute("rowspan");k=!k||0===k||1===k?1:k;m=!m||0===m||1===m?1:m;g=0;for(e=a[f];e[g];)g++;o=g;p=1===k?!0:!1;for(e=0;e<k;e++)for(g=0;g<m;g++)a[f+g][o+e]={cell:i,unique:p},a[f+g].nTr=d}i=i.nextSibling}}}function N(a,b,c){var d=[];c||(c=a.aoHeader,b&&(c=[],V(c,b)));for(var b=0,i=c.length;b<i;b++)for(var f=
0,g=c[b].length;f<g;f++)if(c[b][f].unique&&(!d[f]||!a.bSortCellsTop))d[f]=c[b][f].cell;return d}function wa(a){if(a.bAjaxDataGet){a.iDraw++;E(a,!0);var b=Ea(a);ka(a,b);a.fnServerData.call(a.oInstance,a.sAjaxSource,b,function(b){Fa(a,b)},a);return!1}return!0}function Ea(a){var b=a.aoColumns.length,c=[],d,i,f,g;c.push({name:"sEcho",value:a.iDraw});c.push({name:"iColumns",value:b});c.push({name:"sColumns",value:M(a)});c.push({name:"iDisplayStart",value:a._iDisplayStart});c.push({name:"iDisplayLength",
value:!1!==a.oFeatures.bPaginate?a._iDisplayLength:-1});for(f=0;f<b;f++)d=a.aoColumns[f].mData,c.push({name:"mDataProp_"+f,value:"function"===typeof d?"function":d});if(!1!==a.oFeatures.bFilter){c.push({name:"sSearch",value:a.oPreviousSearch.sSearch});c.push({name:"bRegex",value:a.oPreviousSearch.bRegex});for(f=0;f<b;f++)c.push({name:"sSearch_"+f,value:a.aoPreSearchCols[f].sSearch}),c.push({name:"bRegex_"+f,value:a.aoPreSearchCols[f].bRegex}),c.push({name:"bSearchable_"+f,value:a.aoColumns[f].bSearchable})}if(!1!==
a.oFeatures.bSort){var e=0;d=null!==a.aaSortingFixed?a.aaSortingFixed.concat(a.aaSorting):a.aaSorting.slice();for(f=0;f<d.length;f++){i=a.aoColumns[d[f][0]].aDataSort;for(g=0;g<i.length;g++)c.push({name:"iSortCol_"+e,value:i[g]}),c.push({name:"sSortDir_"+e,value:d[f][1]}),e++}c.push({name:"iSortingCols",value:e});for(f=0;f<b;f++)c.push({name:"bSortable_"+f,value:a.aoColumns[f].bSortable})}return c}function ka(a,b){A(a,"aoServerParams","serverParams",[b])}function Fa(a,b){if(b.sEcho!==n){if(1*b.sEcho<
a.iDraw)return;a.iDraw=1*b.sEcho}(!a.oScroll.bInfinite||a.oScroll.bInfinite&&(a.bSorted||a.bFiltered))&&ga(a);a._iRecordsTotal=parseInt(b.iTotalRecords,10);a._iRecordsDisplay=parseInt(b.iTotalDisplayRecords,10);var c=M(a),c=b.sColumns!==n&&""!==c&&b.sColumns!=c,d;c&&(d=u(a,b.sColumns));for(var i=Q(a.sAjaxDataProp)(b),f=0,g=i.length;f<g;f++)if(c){for(var e=[],h=0,j=a.aoColumns.length;h<j;h++)e.push(i[f][d[h]]);H(a,e)}else H(a,i[f]);a.aiDisplay=a.aiDisplayMaster.slice();a.bAjaxDataGet=!1;x(a);a.bAjaxDataGet=
!0;E(a,!1)}function za(a){var b=a.oPreviousSearch,c=a.oLanguage.sSearch,c=-1!==c.indexOf("_INPUT_")?c.replace("_INPUT_",'<input type="text" />'):""===c?'<input type="text" />':c+' <input type="text" />',d=l.createElement("div");d.className=a.oClasses.sFilter;d.innerHTML="<label>"+c+"</label>";a.aanFeatures.f||(d.id=a.sTableId+"_filter");c=h('input[type="text"]',d);d._DT_Input=c[0];c.val(b.sSearch.replace('"',"&quot;"));c.bind("keyup.DT",function(){for(var c=a.aanFeatures.f,d=this.value===""?"":this.value,
g=0,e=c.length;g<e;g++)c[g]!=h(this).parents("div.dataTables_filter")[0]&&h(c[g]._DT_Input).val(d);d!=b.sSearch&&K(a,{sSearch:d,bRegex:b.bRegex,bSmart:b.bSmart,bCaseInsensitive:b.bCaseInsensitive})});c.attr("aria-controls",a.sTableId).bind("keypress.DT",function(a){if(a.keyCode==13)return false});return d}function K(a,b,c){var d=a.oPreviousSearch,i=a.aoPreSearchCols,f=function(a){d.sSearch=a.sSearch;d.bRegex=a.bRegex;d.bSmart=a.bSmart;d.bCaseInsensitive=a.bCaseInsensitive};if(a.oFeatures.bServerSide)f(b);
else{Ga(a,b.sSearch,c,b.bRegex,b.bSmart,b.bCaseInsensitive);f(b);for(b=0;b<a.aoPreSearchCols.length;b++)Ha(a,i[b].sSearch,b,i[b].bRegex,i[b].bSmart,i[b].bCaseInsensitive);Ia(a)}a.bFiltered=!0;h(a.oInstance).trigger("filter",a);a._iDisplayStart=0;y(a);x(a);la(a,0)}function Ia(a){for(var b=j.ext.afnFiltering,c=r(a,"bSearchable"),d=0,i=b.length;d<i;d++)for(var f=0,g=0,e=a.aiDisplay.length;g<e;g++){var h=a.aiDisplay[g-f];b[d](a,Y(a,h,"filter",c),h)||(a.aiDisplay.splice(g-f,1),f++)}}function Ha(a,b,c,
d,i,f){if(""!==b)for(var g=0,b=ma(b,d,i,f),d=a.aiDisplay.length-1;0<=d;d--)i=Ja(v(a,a.aiDisplay[d],c,"filter"),a.aoColumns[c].sType),b.test(i)||(a.aiDisplay.splice(d,1),g++)}function Ga(a,b,c,d,i,f){d=ma(b,d,i,f);i=a.oPreviousSearch;c||(c=0);0!==j.ext.afnFiltering.length&&(c=1);if(0>=b.length)a.aiDisplay.splice(0,a.aiDisplay.length),a.aiDisplay=a.aiDisplayMaster.slice();else if(a.aiDisplay.length==a.aiDisplayMaster.length||i.sSearch.length>b.length||1==c||0!==b.indexOf(i.sSearch)){a.aiDisplay.splice(0,
a.aiDisplay.length);la(a,1);for(b=0;b<a.aiDisplayMaster.length;b++)d.test(a.asDataSearch[b])&&a.aiDisplay.push(a.aiDisplayMaster[b])}else for(b=c=0;b<a.asDataSearch.length;b++)d.test(a.asDataSearch[b])||(a.aiDisplay.splice(b-c,1),c++)}function la(a,b){if(!a.oFeatures.bServerSide){a.asDataSearch=[];for(var c=r(a,"bSearchable"),d=1===b?a.aiDisplayMaster:a.aiDisplay,i=0,f=d.length;i<f;i++)a.asDataSearch[i]=na(a,Y(a,d[i],"filter",c))}}function na(a,b){var c=b.join("  ");-1!==c.indexOf("&")&&(c=h("<div>").html(c).text());
return c.replace(/[\n\r]/g," ")}function ma(a,b,c,d){if(c)return a=b?a.split(" "):oa(a).split(" "),a="^(?=.*?"+a.join(")(?=.*?")+").*$",RegExp(a,d?"i":"");a=b?a:oa(a);return RegExp(a,d?"i":"")}function Ja(a,b){return"function"===typeof j.ext.ofnSearch[b]?j.ext.ofnSearch[b](a):null===a?"":"html"==b?a.replace(/[\r\n]/g," ").replace(/<.*?>/g,""):"string"===typeof a?a.replace(/[\r\n]/g," "):a}function oa(a){return a.replace(RegExp("(\\/|\\.|\\*|\\+|\\?|\\||\\(|\\)|\\[|\\]|\\{|\\}|\\\\|\\$|\\^|\\-)","g"),
"\\$1")}function Ca(a){var b=l.createElement("div");b.className=a.oClasses.sInfo;a.aanFeatures.i||(a.aoDrawCallback.push({fn:Ka,sName:"information"}),b.id=a.sTableId+"_info");a.nTable.setAttribute("aria-describedby",a.sTableId+"_info");return b}function Ka(a){if(a.oFeatures.bInfo&&0!==a.aanFeatures.i.length){var b=a.oLanguage,c=a._iDisplayStart+1,d=a.fnDisplayEnd(),i=a.fnRecordsTotal(),f=a.fnRecordsDisplay(),g;g=0===f?b.sInfoEmpty:b.sInfo;f!=i&&(g+=" "+b.sInfoFiltered);g+=b.sInfoPostFix;g=ja(a,g);
null!==b.fnInfoCallback&&(g=b.fnInfoCallback.call(a.oInstance,a,c,d,i,f,g));a=a.aanFeatures.i;b=0;for(c=a.length;b<c;b++)h(a[b]).html(g)}}function ja(a,b){var c=a.fnFormatNumber(a._iDisplayStart+1),d=a.fnDisplayEnd(),d=a.fnFormatNumber(d),i=a.fnRecordsDisplay(),i=a.fnFormatNumber(i),f=a.fnRecordsTotal(),f=a.fnFormatNumber(f);a.oScroll.bInfinite&&(c=a.fnFormatNumber(1));return b.replace(/_START_/g,c).replace(/_END_/g,d).replace(/_TOTAL_/g,i).replace(/_MAX_/g,f)}function ba(a){var b,c,d=a.iInitDisplayStart;
if(!1===a.bInitialised)setTimeout(function(){ba(a)},200);else{xa(a);va(a);W(a,a.aoHeader);a.nTFoot&&W(a,a.aoFooter);E(a,!0);a.oFeatures.bAutoWidth&&da(a);b=0;for(c=a.aoColumns.length;b<c;b++)null!==a.aoColumns[b].sWidth&&(a.aoColumns[b].nTh.style.width=q(a.aoColumns[b].sWidth));a.oFeatures.bSort?O(a):a.oFeatures.bFilter?K(a,a.oPreviousSearch):(a.aiDisplay=a.aiDisplayMaster.slice(),y(a),x(a));null!==a.sAjaxSource&&!a.oFeatures.bServerSide?(c=[],ka(a,c),a.fnServerData.call(a.oInstance,a.sAjaxSource,
c,function(c){var f=a.sAjaxDataProp!==""?Q(a.sAjaxDataProp)(c):c;for(b=0;b<f.length;b++)H(a,f[b]);a.iInitDisplayStart=d;if(a.oFeatures.bSort)O(a);else{a.aiDisplay=a.aiDisplayMaster.slice();y(a);x(a)}E(a,false);$(a,c)},a)):a.oFeatures.bServerSide||(E(a,!1),$(a))}}function $(a,b){a._bInitComplete=!0;A(a,"aoInitComplete","init",[a,b])}function pa(a){var b=j.defaults.oLanguage;!a.sEmptyTable&&(a.sZeroRecords&&"No data available in table"===b.sEmptyTable)&&p(a,a,"sZeroRecords","sEmptyTable");!a.sLoadingRecords&&
(a.sZeroRecords&&"Loading..."===b.sLoadingRecords)&&p(a,a,"sZeroRecords","sLoadingRecords")}function ya(a){if(a.oScroll.bInfinite)return null;var b='<select size="1" '+('name="'+a.sTableId+'_length"')+">",c,d,i=a.aLengthMenu;if(2==i.length&&"object"===typeof i[0]&&"object"===typeof i[1]){c=0;for(d=i[0].length;c<d;c++)b+='<option value="'+i[0][c]+'">'+i[1][c]+"</option>"}else{c=0;for(d=i.length;c<d;c++)b+='<option value="'+i[c]+'">'+i[c]+"</option>"}b+="</select>";i=l.createElement("div");a.aanFeatures.l||
(i.id=a.sTableId+"_length");i.className=a.oClasses.sLength;i.innerHTML="<label>"+a.oLanguage.sLengthMenu.replace("_MENU_",b)+"</label>";h('select option[value="'+a._iDisplayLength+'"]',i).attr("selected",!0);h("select",i).bind("change.DT",function(){var b=h(this).val(),i=a.aanFeatures.l;c=0;for(d=i.length;c<d;c++)i[c]!=this.parentNode&&h("select",i[c]).val(b);a._iDisplayLength=parseInt(b,10);y(a);if(a.fnDisplayEnd()==a.fnRecordsDisplay()){a._iDisplayStart=a.fnDisplayEnd()-a._iDisplayLength;if(a._iDisplayStart<
0)a._iDisplayStart=0}if(a._iDisplayLength==-1)a._iDisplayStart=0;x(a)});h("select",i).attr("aria-controls",a.sTableId);return i}function y(a){a._iDisplayEnd=!1===a.oFeatures.bPaginate?a.aiDisplay.length:a._iDisplayStart+a._iDisplayLength>a.aiDisplay.length||-1==a._iDisplayLength?a.aiDisplay.length:a._iDisplayStart+a._iDisplayLength}function Da(a){if(a.oScroll.bInfinite)return null;var b=l.createElement("div");b.className=a.oClasses.sPaging+a.sPaginationType;j.ext.oPagination[a.sPaginationType].fnInit(a,
b,function(a){y(a);x(a)});a.aanFeatures.p||a.aoDrawCallback.push({fn:function(a){j.ext.oPagination[a.sPaginationType].fnUpdate(a,function(a){y(a);x(a)})},sName:"pagination"});return b}function qa(a,b){var c=a._iDisplayStart;if("number"===typeof b)a._iDisplayStart=b*a._iDisplayLength,a._iDisplayStart>a.fnRecordsDisplay()&&(a._iDisplayStart=0);else if("first"==b)a._iDisplayStart=0;else if("previous"==b)a._iDisplayStart=0<=a._iDisplayLength?a._iDisplayStart-a._iDisplayLength:0,0>a._iDisplayStart&&(a._iDisplayStart=
0);else if("next"==b)0<=a._iDisplayLength?a._iDisplayStart+a._iDisplayLength<a.fnRecordsDisplay()&&(a._iDisplayStart+=a._iDisplayLength):a._iDisplayStart=0;else if("last"==b)if(0<=a._iDisplayLength){var d=parseInt((a.fnRecordsDisplay()-1)/a._iDisplayLength,10)+1;a._iDisplayStart=(d-1)*a._iDisplayLength}else a._iDisplayStart=0;else D(a,0,"Unknown paging action: "+b);h(a.oInstance).trigger("page",a);return c!=a._iDisplayStart}function Aa(a){var b=l.createElement("div");a.aanFeatures.r||(b.id=a.sTableId+
"_processing");b.innerHTML=a.oLanguage.sProcessing;b.className=a.oClasses.sProcessing;a.nTable.parentNode.insertBefore(b,a.nTable);return b}function E(a,b){if(a.oFeatures.bProcessing)for(var c=a.aanFeatures.r,d=0,i=c.length;d<i;d++)c[d].style.visibility=b?"visible":"hidden";h(a.oInstance).trigger("processing",[a,b])}function Ba(a){if(""===a.oScroll.sX&&""===a.oScroll.sY)return a.nTable;var b=l.createElement("div"),c=l.createElement("div"),d=l.createElement("div"),i=l.createElement("div"),f=l.createElement("div"),
g=l.createElement("div"),e=a.nTable.cloneNode(!1),j=a.nTable.cloneNode(!1),o=a.nTable.getElementsByTagName("thead")[0],k=0===a.nTable.getElementsByTagName("tfoot").length?null:a.nTable.getElementsByTagName("tfoot")[0],m=a.oClasses;c.appendChild(d);f.appendChild(g);i.appendChild(a.nTable);b.appendChild(c);b.appendChild(i);d.appendChild(e);e.appendChild(o);null!==k&&(b.appendChild(f),g.appendChild(j),j.appendChild(k));b.className=m.sScrollWrapper;c.className=m.sScrollHead;d.className=m.sScrollHeadInner;
i.className=m.sScrollBody;f.className=m.sScrollFoot;g.className=m.sScrollFootInner;a.oScroll.bAutoCss&&(c.style.overflow="hidden",c.style.position="relative",f.style.overflow="hidden",i.style.overflow="auto");c.style.border="0";c.style.width="100%";f.style.border="0";d.style.width=""!==a.oScroll.sXInner?a.oScroll.sXInner:"100%";e.removeAttribute("id");e.style.marginLeft="0";a.nTable.style.marginLeft="0";null!==k&&(j.removeAttribute("id"),j.style.marginLeft="0");d=h(a.nTable).children("caption");0<
d.length&&(d=d[0],"top"===d._captionSide?e.appendChild(d):"bottom"===d._captionSide&&k&&j.appendChild(d));""!==a.oScroll.sX&&(c.style.width=q(a.oScroll.sX),i.style.width=q(a.oScroll.sX),null!==k&&(f.style.width=q(a.oScroll.sX)),h(i).scroll(function(){c.scrollLeft=this.scrollLeft;if(k!==null)f.scrollLeft=this.scrollLeft}));""!==a.oScroll.sY&&(i.style.height=q(a.oScroll.sY));a.aoDrawCallback.push({fn:La,sName:"scrolling"});a.oScroll.bInfinite&&h(i).scroll(function(){if(!a.bDrawing&&h(this).scrollTop()!==
0&&h(this).scrollTop()+h(this).height()>h(a.nTable).height()-a.oScroll.iLoadGap&&a.fnDisplayEnd()<a.fnRecordsDisplay()){qa(a,"next");y(a);x(a)}});a.nScrollHead=c;a.nScrollFoot=f;return b}function La(a){var b=a.nScrollHead.getElementsByTagName("div")[0],c=b.getElementsByTagName("table")[0],d=a.nTable.parentNode,i,f,g,e,j,o,k,m,p=[],n=[],l=null!==a.nTFoot?a.nScrollFoot.getElementsByTagName("div")[0]:null,R=null!==a.nTFoot?l.getElementsByTagName("table")[0]:null,r=a.oBrowser.bScrollOversize,s=function(a){k=
a.style;k.paddingTop="0";k.paddingBottom="0";k.borderTopWidth="0";k.borderBottomWidth="0";k.height=0};h(a.nTable).children("thead, tfoot").remove();i=h(a.nTHead).clone()[0];a.nTable.insertBefore(i,a.nTable.childNodes[0]);g=a.nTHead.getElementsByTagName("tr");e=i.getElementsByTagName("tr");null!==a.nTFoot&&(j=h(a.nTFoot).clone()[0],a.nTable.insertBefore(j,a.nTable.childNodes[1]),o=a.nTFoot.getElementsByTagName("tr"),j=j.getElementsByTagName("tr"));""===a.oScroll.sX&&(d.style.width="100%",b.parentNode.style.width=
"100%");var t=N(a,i);i=0;for(f=t.length;i<f;i++)m=G(a,i),t[i].style.width=a.aoColumns[m].sWidth;null!==a.nTFoot&&C(function(a){a.style.width=""},j);a.oScroll.bCollapse&&""!==a.oScroll.sY&&(d.style.height=d.offsetHeight+a.nTHead.offsetHeight+"px");i=h(a.nTable).outerWidth();if(""===a.oScroll.sX){if(a.nTable.style.width="100%",r&&(h("tbody",d).height()>d.offsetHeight||"scroll"==h(d).css("overflow-y")))a.nTable.style.width=q(h(a.nTable).outerWidth()-a.oScroll.iBarWidth)}else""!==a.oScroll.sXInner?a.nTable.style.width=
q(a.oScroll.sXInner):i==h(d).width()&&h(d).height()<h(a.nTable).height()?(a.nTable.style.width=q(i-a.oScroll.iBarWidth),h(a.nTable).outerWidth()>i-a.oScroll.iBarWidth&&(a.nTable.style.width=q(i))):a.nTable.style.width=q(i);i=h(a.nTable).outerWidth();C(s,e);C(function(a){p.push(q(h(a).width()))},e);C(function(a,b){a.style.width=p[b]},g);h(e).height(0);null!==a.nTFoot&&(C(s,j),C(function(a){n.push(q(h(a).width()))},j),C(function(a,b){a.style.width=n[b]},o),h(j).height(0));C(function(a,b){a.innerHTML=
"";a.style.width=p[b]},e);null!==a.nTFoot&&C(function(a,b){a.innerHTML="";a.style.width=n[b]},j);if(h(a.nTable).outerWidth()<i){g=d.scrollHeight>d.offsetHeight||"scroll"==h(d).css("overflow-y")?i+a.oScroll.iBarWidth:i;if(r&&(d.scrollHeight>d.offsetHeight||"scroll"==h(d).css("overflow-y")))a.nTable.style.width=q(g-a.oScroll.iBarWidth);d.style.width=q(g);a.nScrollHead.style.width=q(g);null!==a.nTFoot&&(a.nScrollFoot.style.width=q(g));""===a.oScroll.sX?D(a,1,"The table cannot fit into the current element which will cause column misalignment. The table has been drawn at its minimum possible width."):
""!==a.oScroll.sXInner&&D(a,1,"The table cannot fit into the current element which will cause column misalignment. Increase the sScrollXInner value or remove it to allow automatic calculation")}else d.style.width=q("100%"),a.nScrollHead.style.width=q("100%"),null!==a.nTFoot&&(a.nScrollFoot.style.width=q("100%"));""===a.oScroll.sY&&r&&(d.style.height=q(a.nTable.offsetHeight+a.oScroll.iBarWidth));""!==a.oScroll.sY&&a.oScroll.bCollapse&&(d.style.height=q(a.oScroll.sY),r=""!==a.oScroll.sX&&a.nTable.offsetWidth>
d.offsetWidth?a.oScroll.iBarWidth:0,a.nTable.offsetHeight<d.offsetHeight&&(d.style.height=q(a.nTable.offsetHeight+r)));r=h(a.nTable).outerWidth();c.style.width=q(r);b.style.width=q(r);c=h(a.nTable).height()>d.clientHeight||"scroll"==h(d).css("overflow-y");b.style.paddingRight=c?a.oScroll.iBarWidth+"px":"0px";null!==a.nTFoot&&(R.style.width=q(r),l.style.width=q(r),l.style.paddingRight=c?a.oScroll.iBarWidth+"px":"0px");h(d).scroll();if(a.bSorted||a.bFiltered)d.scrollTop=0}function C(a,b,c){for(var d=
0,i=0,f=b.length,g,e;i<f;){g=b[i].firstChild;for(e=c?c[i].firstChild:null;g;)1===g.nodeType&&(c?a(g,e,d):a(g,d),d++),g=g.nextSibling,e=c?e.nextSibling:null;i++}}function Ma(a,b){if(!a||null===a||""===a)return 0;b||(b=l.body);var c,d=l.createElement("div");d.style.width=q(a);b.appendChild(d);c=d.offsetWidth;b.removeChild(d);return c}function da(a){var b=0,c,d=0,i=a.aoColumns.length,f,e,j=h("th",a.nTHead),o=a.nTable.getAttribute("width");e=a.nTable.parentNode;for(f=0;f<i;f++)a.aoColumns[f].bVisible&&
(d++,null!==a.aoColumns[f].sWidth&&(c=Ma(a.aoColumns[f].sWidthOrig,e),null!==c&&(a.aoColumns[f].sWidth=q(c)),b++));if(i==j.length&&0===b&&d==i&&""===a.oScroll.sX&&""===a.oScroll.sY)for(f=0;f<a.aoColumns.length;f++)c=h(j[f]).width(),null!==c&&(a.aoColumns[f].sWidth=q(c));else{b=a.nTable.cloneNode(!1);f=a.nTHead.cloneNode(!0);d=l.createElement("tbody");c=l.createElement("tr");b.removeAttribute("id");b.appendChild(f);null!==a.nTFoot&&(b.appendChild(a.nTFoot.cloneNode(!0)),C(function(a){a.style.width=
""},b.getElementsByTagName("tr")));b.appendChild(d);d.appendChild(c);d=h("thead th",b);0===d.length&&(d=h("tbody tr:eq(0)>td",b));j=N(a,f);for(f=d=0;f<i;f++){var k=a.aoColumns[f];k.bVisible&&null!==k.sWidthOrig&&""!==k.sWidthOrig?j[f-d].style.width=q(k.sWidthOrig):k.bVisible?j[f-d].style.width="":d++}for(f=0;f<i;f++)a.aoColumns[f].bVisible&&(d=Na(a,f),null!==d&&(d=d.cloneNode(!0),""!==a.aoColumns[f].sContentPadding&&(d.innerHTML+=a.aoColumns[f].sContentPadding),c.appendChild(d)));e.appendChild(b);
""!==a.oScroll.sX&&""!==a.oScroll.sXInner?b.style.width=q(a.oScroll.sXInner):""!==a.oScroll.sX?(b.style.width="",h(b).width()<e.offsetWidth&&(b.style.width=q(e.offsetWidth))):""!==a.oScroll.sY?b.style.width=q(e.offsetWidth):o&&(b.style.width=q(o));b.style.visibility="hidden";Oa(a,b);i=h("tbody tr:eq(0)",b).children();0===i.length&&(i=N(a,h("thead",b)[0]));if(""!==a.oScroll.sX){for(f=d=e=0;f<a.aoColumns.length;f++)a.aoColumns[f].bVisible&&(e=null===a.aoColumns[f].sWidthOrig?e+h(i[d]).outerWidth():
e+(parseInt(a.aoColumns[f].sWidth.replace("px",""),10)+(h(i[d]).outerWidth()-h(i[d]).width())),d++);b.style.width=q(e);a.nTable.style.width=q(e)}for(f=d=0;f<a.aoColumns.length;f++)a.aoColumns[f].bVisible&&(e=h(i[d]).width(),null!==e&&0<e&&(a.aoColumns[f].sWidth=q(e)),d++);i=h(b).css("width");a.nTable.style.width=-1!==i.indexOf("%")?i:q(h(b).outerWidth());b.parentNode.removeChild(b)}o&&(a.nTable.style.width=q(o))}function Oa(a,b){""===a.oScroll.sX&&""!==a.oScroll.sY?(h(b).width(),b.style.width=q(h(b).outerWidth()-
a.oScroll.iBarWidth)):""!==a.oScroll.sX&&(b.style.width=q(h(b).outerWidth()))}function Na(a,b){var c=Pa(a,b);if(0>c)return null;if(null===a.aoData[c].nTr){var d=l.createElement("td");d.innerHTML=v(a,c,b,"");return d}return J(a,c)[b]}function Pa(a,b){for(var c=-1,d=-1,i=0;i<a.aoData.length;i++){var e=v(a,i,b,"display")+"",e=e.replace(/<.*?>/g,"");e.length>c&&(c=e.length,d=i)}return d}function q(a){if(null===a)return"0px";if("number"==typeof a)return 0>a?"0px":a+"px";var b=a.charCodeAt(a.length-1);
return 48>b||57<b?a:a+"px"}function Qa(){var a=l.createElement("p"),b=a.style;b.width="100%";b.height="200px";b.padding="0px";var c=l.createElement("div"),b=c.style;b.position="absolute";b.top="0px";b.left="0px";b.visibility="hidden";b.width="200px";b.height="150px";b.padding="0px";b.overflow="hidden";c.appendChild(a);l.body.appendChild(c);b=a.offsetWidth;c.style.overflow="scroll";a=a.offsetWidth;b==a&&(a=c.clientWidth);l.body.removeChild(c);return b-a}function O(a,b){var c,d,i,e,g,k,o=[],m=[],p=
j.ext.oSort,l=a.aoData,q=a.aoColumns,G=a.oLanguage.oAria;if(!a.oFeatures.bServerSide&&(0!==a.aaSorting.length||null!==a.aaSortingFixed)){o=null!==a.aaSortingFixed?a.aaSortingFixed.concat(a.aaSorting):a.aaSorting.slice();for(c=0;c<o.length;c++)if(d=o[c][0],i=R(a,d),e=a.aoColumns[d].sSortDataType,j.ext.afnSortData[e])if(g=j.ext.afnSortData[e].call(a.oInstance,a,d,i),g.length===l.length){i=0;for(e=l.length;i<e;i++)F(a,i,d,g[i])}else D(a,0,"Returned data sort array (col "+d+") is the wrong length");c=
0;for(d=a.aiDisplayMaster.length;c<d;c++)m[a.aiDisplayMaster[c]]=c;var r=o.length,s;c=0;for(d=l.length;c<d;c++)for(i=0;i<r;i++){s=q[o[i][0]].aDataSort;g=0;for(k=s.length;g<k;g++)e=q[s[g]].sType,e=p[(e?e:"string")+"-pre"],l[c]._aSortData[s[g]]=e?e(v(a,c,s[g],"sort")):v(a,c,s[g],"sort")}a.aiDisplayMaster.sort(function(a,b){var c,d,e,i,f;for(c=0;c<r;c++){f=q[o[c][0]].aDataSort;d=0;for(e=f.length;d<e;d++)if(i=q[f[d]].sType,i=p[(i?i:"string")+"-"+o[c][1]](l[a]._aSortData[f[d]],l[b]._aSortData[f[d]]),0!==
i)return i}return p["numeric-asc"](m[a],m[b])})}(b===n||b)&&!a.oFeatures.bDeferRender&&P(a);c=0;for(d=a.aoColumns.length;c<d;c++)e=q[c].sTitle.replace(/<.*?>/g,""),i=q[c].nTh,i.removeAttribute("aria-sort"),i.removeAttribute("aria-label"),q[c].bSortable?0<o.length&&o[0][0]==c?(i.setAttribute("aria-sort","asc"==o[0][1]?"ascending":"descending"),i.setAttribute("aria-label",e+("asc"==(q[c].asSorting[o[0][2]+1]?q[c].asSorting[o[0][2]+1]:q[c].asSorting[0])?G.sSortAscending:G.sSortDescending))):i.setAttribute("aria-label",
e+("asc"==q[c].asSorting[0]?G.sSortAscending:G.sSortDescending)):i.setAttribute("aria-label",e);a.bSorted=!0;h(a.oInstance).trigger("sort",a);a.oFeatures.bFilter?K(a,a.oPreviousSearch,1):(a.aiDisplay=a.aiDisplayMaster.slice(),a._iDisplayStart=0,y(a),x(a))}function ia(a,b,c,d){Ra(b,{},function(b){if(!1!==a.aoColumns[c].bSortable){var e=function(){var d,e;if(b.shiftKey){for(var f=!1,h=0;h<a.aaSorting.length;h++)if(a.aaSorting[h][0]==c){f=!0;d=a.aaSorting[h][0];e=a.aaSorting[h][2]+1;a.aoColumns[d].asSorting[e]?
(a.aaSorting[h][1]=a.aoColumns[d].asSorting[e],a.aaSorting[h][2]=e):a.aaSorting.splice(h,1);break}!1===f&&a.aaSorting.push([c,a.aoColumns[c].asSorting[0],0])}else 1==a.aaSorting.length&&a.aaSorting[0][0]==c?(d=a.aaSorting[0][0],e=a.aaSorting[0][2]+1,a.aoColumns[d].asSorting[e]||(e=0),a.aaSorting[0][1]=a.aoColumns[d].asSorting[e],a.aaSorting[0][2]=e):(a.aaSorting.splice(0,a.aaSorting.length),a.aaSorting.push([c,a.aoColumns[c].asSorting[0],0]));O(a)};a.oFeatures.bProcessing?(E(a,!0),setTimeout(function(){e();
a.oFeatures.bServerSide||E(a,!1)},0)):e();"function"==typeof d&&d(a)}})}function P(a){var b,c,d,e,f,g=a.aoColumns.length,j=a.oClasses;for(b=0;b<g;b++)a.aoColumns[b].bSortable&&h(a.aoColumns[b].nTh).removeClass(j.sSortAsc+" "+j.sSortDesc+" "+a.aoColumns[b].sSortingClass);c=null!==a.aaSortingFixed?a.aaSortingFixed.concat(a.aaSorting):a.aaSorting.slice();for(b=0;b<a.aoColumns.length;b++)if(a.aoColumns[b].bSortable){f=a.aoColumns[b].sSortingClass;e=-1;for(d=0;d<c.length;d++)if(c[d][0]==b){f="asc"==c[d][1]?
j.sSortAsc:j.sSortDesc;e=d;break}h(a.aoColumns[b].nTh).addClass(f);a.bJUI&&(f=h("span."+j.sSortIcon,a.aoColumns[b].nTh),f.removeClass(j.sSortJUIAsc+" "+j.sSortJUIDesc+" "+j.sSortJUI+" "+j.sSortJUIAscAllowed+" "+j.sSortJUIDescAllowed),f.addClass(-1==e?a.aoColumns[b].sSortingClassJUI:"asc"==c[e][1]?j.sSortJUIAsc:j.sSortJUIDesc))}else h(a.aoColumns[b].nTh).addClass(a.aoColumns[b].sSortingClass);f=j.sSortColumn;if(a.oFeatures.bSort&&a.oFeatures.bSortClasses){a=J(a);e=[];for(b=0;b<g;b++)e.push("");b=0;
for(d=1;b<c.length;b++)j=parseInt(c[b][0],10),e[j]=f+d,3>d&&d++;f=RegExp(f+"[123]");var o;b=0;for(c=a.length;b<c;b++)j=b%g,d=a[b].className,o=e[j],j=d.replace(f,o),j!=d?a[b].className=h.trim(j):0<o.length&&-1==d.indexOf(o)&&(a[b].className=d+" "+o)}}function ra(a){if(a.oFeatures.bStateSave&&!a.bDestroying){var b,c;b=a.oScroll.bInfinite;var d={iCreate:(new Date).getTime(),iStart:b?0:a._iDisplayStart,iEnd:b?a._iDisplayLength:a._iDisplayEnd,iLength:a._iDisplayLength,aaSorting:h.extend(!0,[],a.aaSorting),
oSearch:h.extend(!0,{},a.oPreviousSearch),aoSearchCols:h.extend(!0,[],a.aoPreSearchCols),abVisCols:[]};b=0;for(c=a.aoColumns.length;b<c;b++)d.abVisCols.push(a.aoColumns[b].bVisible);A(a,"aoStateSaveParams","stateSaveParams",[a,d]);a.fnStateSave.call(a.oInstance,a,d)}}function Sa(a,b){if(a.oFeatures.bStateSave){var c=a.fnStateLoad.call(a.oInstance,a);if(c){var d=A(a,"aoStateLoadParams","stateLoadParams",[a,c]);if(-1===h.inArray(!1,d)){a.oLoadedState=h.extend(!0,{},c);a._iDisplayStart=c.iStart;a.iInitDisplayStart=
c.iStart;a._iDisplayEnd=c.iEnd;a._iDisplayLength=c.iLength;a.aaSorting=c.aaSorting.slice();a.saved_aaSorting=c.aaSorting.slice();h.extend(a.oPreviousSearch,c.oSearch);h.extend(!0,a.aoPreSearchCols,c.aoSearchCols);b.saved_aoColumns=[];for(d=0;d<c.abVisCols.length;d++)b.saved_aoColumns[d]={},b.saved_aoColumns[d].bVisible=c.abVisCols[d];A(a,"aoStateLoaded","stateLoaded",[a,c])}}}}function s(a){for(var b=0;b<j.settings.length;b++)if(j.settings[b].nTable===a)return j.settings[b];return null}function T(a){for(var b=
[],a=a.aoData,c=0,d=a.length;c<d;c++)null!==a[c].nTr&&b.push(a[c].nTr);return b}function J(a,b){var c=[],d,e,f,g,h,j;e=0;var o=a.aoData.length;b!==n&&(e=b,o=b+1);for(f=e;f<o;f++)if(j=a.aoData[f],null!==j.nTr){e=[];for(d=j.nTr.firstChild;d;)g=d.nodeName.toLowerCase(),("td"==g||"th"==g)&&e.push(d),d=d.nextSibling;g=d=0;for(h=a.aoColumns.length;g<h;g++)a.aoColumns[g].bVisible?c.push(e[g-d]):(c.push(j._anHidden[g]),d++)}return c}function D(a,b,c){a=null===a?"DataTables warning: "+c:"DataTables warning (table id = '"+
a.sTableId+"'): "+c;if(0===b)if("alert"==j.ext.sErrMode)alert(a);else throw Error(a);else X.console&&console.log&&console.log(a)}function p(a,b,c,d){d===n&&(d=c);b[c]!==n&&(a[d]=b[c])}function Ta(a,b){var c,d;for(d in b)b.hasOwnProperty(d)&&(c=b[d],"object"===typeof e[d]&&null!==c&&!1===h.isArray(c)?h.extend(!0,a[d],c):a[d]=c);return a}function Ra(a,b,c){h(a).bind("click.DT",b,function(b){a.blur();c(b)}).bind("keypress.DT",b,function(a){13===a.which&&c(a)}).bind("selectstart.DT",function(){return!1})}
function z(a,b,c,d){c&&a[b].push({fn:c,sName:d})}function A(a,b,c,d){for(var b=a[b],e=[],f=b.length-1;0<=f;f--)e.push(b[f].fn.apply(a.oInstance,d));null!==c&&h(a.oInstance).trigger(c,d);return e}function Ua(a){var b=h('<div style="position:absolute; top:0; left:0; height:1px; width:1px; overflow:hidden"><div style="position:absolute; top:1px; left:1px; width:100px; overflow:scroll;"><div id="DT_BrowserTest" style="width:100%; height:10px;"></div></div></div>')[0];l.body.appendChild(b);a.oBrowser.bScrollOversize=
100===h("#DT_BrowserTest",b)[0].offsetWidth?!0:!1;l.body.removeChild(b)}function Va(a){return function(){var b=[s(this[j.ext.iApiIndex])].concat(Array.prototype.slice.call(arguments));return j.ext.oApi[a].apply(this,b)}}var U=/\[.*?\]$/,Wa=X.JSON?JSON.stringify:function(a){var b=typeof a;if("object"!==b||null===a)return"string"===b&&(a='"'+a+'"'),a+"";var c,d,e=[],f=h.isArray(a);for(c in a)d=a[c],b=typeof d,"string"===b?d='"'+d+'"':"object"===b&&null!==d&&(d=Wa(d)),e.push((f?"":'"'+c+'":')+d);return(f?
"[":"{")+e+(f?"]":"}")};this.$=function(a,b){var c,d,e=[],f;d=s(this[j.ext.iApiIndex]);var g=d.aoData,o=d.aiDisplay,k=d.aiDisplayMaster;b||(b={});b=h.extend({},{filter:"none",order:"current",page:"all"},b);if("current"==b.page){c=d._iDisplayStart;for(d=d.fnDisplayEnd();c<d;c++)(f=g[o[c]].nTr)&&e.push(f)}else if("current"==b.order&&"none"==b.filter){c=0;for(d=k.length;c<d;c++)(f=g[k[c]].nTr)&&e.push(f)}else if("current"==b.order&&"applied"==b.filter){c=0;for(d=o.length;c<d;c++)(f=g[o[c]].nTr)&&e.push(f)}else if("original"==
b.order&&"none"==b.filter){c=0;for(d=g.length;c<d;c++)(f=g[c].nTr)&&e.push(f)}else if("original"==b.order&&"applied"==b.filter){c=0;for(d=g.length;c<d;c++)f=g[c].nTr,-1!==h.inArray(c,o)&&f&&e.push(f)}else D(d,1,"Unknown selection options");e=h(e);c=e.filter(a);e=e.find(a);return h([].concat(h.makeArray(c),h.makeArray(e)))};this._=function(a,b){var c=[],d,e,f=this.$(a,b);d=0;for(e=f.length;d<e;d++)c.push(this.fnGetData(f[d]));return c};this.fnAddData=function(a,b){if(0===a.length)return[];var c=[],
d,e=s(this[j.ext.iApiIndex]);if("object"===typeof a[0]&&null!==a[0])for(var f=0;f<a.length;f++){d=H(e,a[f]);if(-1==d)return c;c.push(d)}else{d=H(e,a);if(-1==d)return c;c.push(d)}e.aiDisplay=e.aiDisplayMaster.slice();(b===n||b)&&aa(e);return c};this.fnAdjustColumnSizing=function(a){var b=s(this[j.ext.iApiIndex]);k(b);a===n||a?this.fnDraw(!1):(""!==b.oScroll.sX||""!==b.oScroll.sY)&&this.oApi._fnScrollDraw(b)};this.fnClearTable=function(a){var b=s(this[j.ext.iApiIndex]);ga(b);(a===n||a)&&x(b)};this.fnClose=
function(a){for(var b=s(this[j.ext.iApiIndex]),c=0;c<b.aoOpenRows.length;c++)if(b.aoOpenRows[c].nParent==a)return(a=b.aoOpenRows[c].nTr.parentNode)&&a.removeChild(b.aoOpenRows[c].nTr),b.aoOpenRows.splice(c,1),0;return 1};this.fnDeleteRow=function(a,b,c){var d=s(this[j.ext.iApiIndex]),e,f,a="object"===typeof a?I(d,a):a,g=d.aoData.splice(a,1);e=0;for(f=d.aoData.length;e<f;e++)null!==d.aoData[e].nTr&&(d.aoData[e].nTr._DT_RowIndex=e);e=h.inArray(a,d.aiDisplay);d.asDataSearch.splice(e,1);ha(d.aiDisplayMaster,
a);ha(d.aiDisplay,a);"function"===typeof b&&b.call(this,d,g);d._iDisplayStart>=d.fnRecordsDisplay()&&(d._iDisplayStart-=d._iDisplayLength,0>d._iDisplayStart&&(d._iDisplayStart=0));if(c===n||c)y(d),x(d);return g};this.fnDestroy=function(a){var b=s(this[j.ext.iApiIndex]),c=b.nTableWrapper.parentNode,d=b.nTBody,i,f,a=a===n?!1:a;b.bDestroying=!0;A(b,"aoDestroyCallback","destroy",[b]);if(!a){i=0;for(f=b.aoColumns.length;i<f;i++)!1===b.aoColumns[i].bVisible&&this.fnSetColumnVis(i,!0)}h(b.nTableWrapper).find("*").andSelf().unbind(".DT");
h("tbody>tr>td."+b.oClasses.sRowEmpty,b.nTable).parent().remove();b.nTable!=b.nTHead.parentNode&&(h(b.nTable).children("thead").remove(),b.nTable.appendChild(b.nTHead));b.nTFoot&&b.nTable!=b.nTFoot.parentNode&&(h(b.nTable).children("tfoot").remove(),b.nTable.appendChild(b.nTFoot));b.nTable.parentNode.removeChild(b.nTable);h(b.nTableWrapper).remove();b.aaSorting=[];b.aaSortingFixed=[];P(b);h(T(b)).removeClass(b.asStripeClasses.join(" "));h("th, td",b.nTHead).removeClass([b.oClasses.sSortable,b.oClasses.sSortableAsc,
b.oClasses.sSortableDesc,b.oClasses.sSortableNone].join(" "));b.bJUI&&(h("th span."+b.oClasses.sSortIcon+", td span."+b.oClasses.sSortIcon,b.nTHead).remove(),h("th, td",b.nTHead).each(function(){var a=h("div."+b.oClasses.sSortJUIWrapper,this),c=a.contents();h(this).append(c);a.remove()}));!a&&b.nTableReinsertBefore?c.insertBefore(b.nTable,b.nTableReinsertBefore):a||c.appendChild(b.nTable);i=0;for(f=b.aoData.length;i<f;i++)null!==b.aoData[i].nTr&&d.appendChild(b.aoData[i].nTr);!0===b.oFeatures.bAutoWidth&&
(b.nTable.style.width=q(b.sDestroyWidth));if(f=b.asDestroyStripes.length){a=h(d).children("tr");for(i=0;i<f;i++)a.filter(":nth-child("+f+"n + "+i+")").addClass(b.asDestroyStripes[i])}i=0;for(f=j.settings.length;i<f;i++)j.settings[i]==b&&j.settings.splice(i,1);e=b=null};this.fnDraw=function(a){var b=s(this[j.ext.iApiIndex]);!1===a?(y(b),x(b)):aa(b)};this.fnFilter=function(a,b,c,d,e,f){var g=s(this[j.ext.iApiIndex]);if(g.oFeatures.bFilter){if(c===n||null===c)c=!1;if(d===n||null===d)d=!0;if(e===n||null===
e)e=!0;if(f===n||null===f)f=!0;if(b===n||null===b){if(K(g,{sSearch:a+"",bRegex:c,bSmart:d,bCaseInsensitive:f},1),e&&g.aanFeatures.f){b=g.aanFeatures.f;c=0;for(d=b.length;c<d;c++)try{b[c]._DT_Input!=l.activeElement&&h(b[c]._DT_Input).val(a)}catch(o){h(b[c]._DT_Input).val(a)}}}else h.extend(g.aoPreSearchCols[b],{sSearch:a+"",bRegex:c,bSmart:d,bCaseInsensitive:f}),K(g,g.oPreviousSearch,1)}};this.fnGetData=function(a,b){var c=s(this[j.ext.iApiIndex]);if(a!==n){var d=a;if("object"===typeof a){var e=a.nodeName.toLowerCase();
"tr"===e?d=I(c,a):"td"===e&&(d=I(c,a.parentNode),b=fa(c,d,a))}return b!==n?v(c,d,b,""):c.aoData[d]!==n?c.aoData[d]._aData:null}return Z(c)};this.fnGetNodes=function(a){var b=s(this[j.ext.iApiIndex]);return a!==n?b.aoData[a]!==n?b.aoData[a].nTr:null:T(b)};this.fnGetPosition=function(a){var b=s(this[j.ext.iApiIndex]),c=a.nodeName.toUpperCase();return"TR"==c?I(b,a):"TD"==c||"TH"==c?(c=I(b,a.parentNode),a=fa(b,c,a),[c,R(b,a),a]):null};this.fnIsOpen=function(a){for(var b=s(this[j.ext.iApiIndex]),c=0;c<
b.aoOpenRows.length;c++)if(b.aoOpenRows[c].nParent==a)return!0;return!1};this.fnOpen=function(a,b,c){var d=s(this[j.ext.iApiIndex]),e=T(d);if(-1!==h.inArray(a,e)){this.fnClose(a);var e=l.createElement("tr"),f=l.createElement("td");e.appendChild(f);f.className=c;f.colSpan=t(d);"string"===typeof b?f.innerHTML=b:h(f).html(b);b=h("tr",d.nTBody);-1!=h.inArray(a,b)&&h(e).insertAfter(a);d.aoOpenRows.push({nTr:e,nParent:a});return e}};this.fnPageChange=function(a,b){var c=s(this[j.ext.iApiIndex]);qa(c,a);
y(c);(b===n||b)&&x(c)};this.fnSetColumnVis=function(a,b,c){var d=s(this[j.ext.iApiIndex]),e,f,g=d.aoColumns,h=d.aoData,o,m;if(g[a].bVisible!=b){if(b){for(e=f=0;e<a;e++)g[e].bVisible&&f++;m=f>=t(d);if(!m)for(e=a;e<g.length;e++)if(g[e].bVisible){o=e;break}e=0;for(f=h.length;e<f;e++)null!==h[e].nTr&&(m?h[e].nTr.appendChild(h[e]._anHidden[a]):h[e].nTr.insertBefore(h[e]._anHidden[a],J(d,e)[o]))}else{e=0;for(f=h.length;e<f;e++)null!==h[e].nTr&&(o=J(d,e)[a],h[e]._anHidden[a]=o,o.parentNode.removeChild(o))}g[a].bVisible=
b;W(d,d.aoHeader);d.nTFoot&&W(d,d.aoFooter);e=0;for(f=d.aoOpenRows.length;e<f;e++)d.aoOpenRows[e].nTr.colSpan=t(d);if(c===n||c)k(d),x(d);ra(d)}};this.fnSettings=function(){return s(this[j.ext.iApiIndex])};this.fnSort=function(a){var b=s(this[j.ext.iApiIndex]);b.aaSorting=a;O(b)};this.fnSortListener=function(a,b,c){ia(s(this[j.ext.iApiIndex]),a,b,c)};this.fnUpdate=function(a,b,c,d,e){var f=s(this[j.ext.iApiIndex]),b="object"===typeof b?I(f,b):b;if(h.isArray(a)&&c===n){f.aoData[b]._aData=a.slice();
for(c=0;c<f.aoColumns.length;c++)this.fnUpdate(v(f,b,c),b,c,!1,!1)}else if(h.isPlainObject(a)&&c===n){f.aoData[b]._aData=h.extend(!0,{},a);for(c=0;c<f.aoColumns.length;c++)this.fnUpdate(v(f,b,c),b,c,!1,!1)}else{F(f,b,c,a);var a=v(f,b,c,"display"),g=f.aoColumns[c];null!==g.fnRender&&(a=S(f,b,c),g.bUseRendered&&F(f,b,c,a));null!==f.aoData[b].nTr&&(J(f,b)[c].innerHTML=a)}c=h.inArray(b,f.aiDisplay);f.asDataSearch[c]=na(f,Y(f,b,"filter",r(f,"bSearchable")));(e===n||e)&&k(f);(d===n||d)&&aa(f);return 0};
this.fnVersionCheck=j.ext.fnVersionCheck;this.oApi={_fnExternApiFunc:Va,_fnInitialise:ba,_fnInitComplete:$,_fnLanguageCompat:pa,_fnAddColumn:o,_fnColumnOptions:m,_fnAddData:H,_fnCreateTr:ea,_fnGatherData:ua,_fnBuildHead:va,_fnDrawHead:W,_fnDraw:x,_fnReDraw:aa,_fnAjaxUpdate:wa,_fnAjaxParameters:Ea,_fnAjaxUpdateDraw:Fa,_fnServerParams:ka,_fnAddOptionsHtml:xa,_fnFeatureHtmlTable:Ba,_fnScrollDraw:La,_fnAdjustColumnSizing:k,_fnFeatureHtmlFilter:za,_fnFilterComplete:K,_fnFilterCustom:Ia,_fnFilterColumn:Ha,
_fnFilter:Ga,_fnBuildSearchArray:la,_fnBuildSearchRow:na,_fnFilterCreateSearch:ma,_fnDataToSearch:Ja,_fnSort:O,_fnSortAttachListener:ia,_fnSortingClasses:P,_fnFeatureHtmlPaginate:Da,_fnPageChange:qa,_fnFeatureHtmlInfo:Ca,_fnUpdateInfo:Ka,_fnFeatureHtmlLength:ya,_fnFeatureHtmlProcessing:Aa,_fnProcessingDisplay:E,_fnVisibleToColumnIndex:G,_fnColumnIndexToVisible:R,_fnNodeToDataIndex:I,_fnVisbleColumns:t,_fnCalculateEnd:y,_fnConvertToWidth:Ma,_fnCalculateColumnWidths:da,_fnScrollingWidthAdjust:Oa,_fnGetWidestNode:Na,
_fnGetMaxLenString:Pa,_fnStringToCss:q,_fnDetectType:B,_fnSettingsFromNode:s,_fnGetDataMaster:Z,_fnGetTrNodes:T,_fnGetTdNodes:J,_fnEscapeRegex:oa,_fnDeleteIndex:ha,_fnReOrderIndex:u,_fnColumnOrdering:M,_fnLog:D,_fnClearTable:ga,_fnSaveState:ra,_fnLoadState:Sa,_fnCreateCookie:function(a,b,c,d,e){var f=new Date;f.setTime(f.getTime()+1E3*c);var c=X.location.pathname.split("/"),a=a+"_"+c.pop().replace(/[\/:]/g,"").toLowerCase(),g;null!==e?(g="function"===typeof h.parseJSON?h.parseJSON(b):eval("("+b+")"),
b=e(a,g,f.toGMTString(),c.join("/")+"/")):b=a+"="+encodeURIComponent(b)+"; expires="+f.toGMTString()+"; path="+c.join("/")+"/";a=l.cookie.split(";");e=b.split(";")[0].length;f=[];if(4096<e+l.cookie.length+10){for(var j=0,o=a.length;j<o;j++)if(-1!=a[j].indexOf(d)){var k=a[j].split("=");try{(g=eval("("+decodeURIComponent(k[1])+")"))&&g.iCreate&&f.push({name:k[0],time:g.iCreate})}catch(m){}}for(f.sort(function(a,b){return b.time-a.time});4096<e+l.cookie.length+10;){if(0===f.length)return;d=f.pop();l.cookie=
d.name+"=; expires=Thu, 01-Jan-1970 00:00:01 GMT; path="+c.join("/")+"/"}}l.cookie=b},_fnReadCookie:function(a){for(var b=X.location.pathname.split("/"),a=a+"_"+b[b.length-1].replace(/[\/:]/g,"").toLowerCase()+"=",b=l.cookie.split(";"),c=0;c<b.length;c++){for(var d=b[c];" "==d.charAt(0);)d=d.substring(1,d.length);if(0===d.indexOf(a))return decodeURIComponent(d.substring(a.length,d.length))}return null},_fnDetectHeader:V,_fnGetUniqueThs:N,_fnScrollBarWidth:Qa,_fnApplyToChildren:C,_fnMap:p,_fnGetRowData:Y,
_fnGetCellData:v,_fnSetCellData:F,_fnGetObjectDataFn:Q,_fnSetObjectDataFn:L,_fnApplyColumnDefs:ta,_fnBindAction:Ra,_fnExtend:Ta,_fnCallbackReg:z,_fnCallbackFire:A,_fnJsonString:Wa,_fnRender:S,_fnNodeToColumnIndex:fa,_fnInfoMacros:ja,_fnBrowserDetect:Ua,_fnGetColumns:r};h.extend(j.ext.oApi,this.oApi);for(var sa in j.ext.oApi)sa&&(this[sa]=Va(sa));var ca=this;this.each(function(){var a=0,b,c,d;c=this.getAttribute("id");var i=!1,f=!1;if("table"!=this.nodeName.toLowerCase())D(null,0,"Attempted to initialise DataTables on a node which is not a table: "+
this.nodeName);else{a=0;for(b=j.settings.length;a<b;a++){if(j.settings[a].nTable==this){if(e===n||e.bRetrieve)return j.settings[a].oInstance;if(e.bDestroy){j.settings[a].oInstance.fnDestroy();break}else{D(j.settings[a],0,"Cannot reinitialise DataTable.\n\nTo retrieve the DataTables object for this table, pass no arguments or see the docs for bRetrieve and bDestroy");return}}if(j.settings[a].sTableId==this.id){j.settings.splice(a,1);break}}if(null===c||""===c)this.id=c="DataTables_Table_"+j.ext._oExternConfig.iNextUnique++;
var g=h.extend(!0,{},j.models.oSettings,{nTable:this,oApi:ca.oApi,oInit:e,sDestroyWidth:h(this).width(),sInstance:c,sTableId:c});j.settings.push(g);g.oInstance=1===ca.length?ca:h(this).dataTable();e||(e={});e.oLanguage&&pa(e.oLanguage);e=Ta(h.extend(!0,{},j.defaults),e);p(g.oFeatures,e,"bPaginate");p(g.oFeatures,e,"bLengthChange");p(g.oFeatures,e,"bFilter");p(g.oFeatures,e,"bSort");p(g.oFeatures,e,"bInfo");p(g.oFeatures,e,"bProcessing");p(g.oFeatures,e,"bAutoWidth");p(g.oFeatures,e,"bSortClasses");
p(g.oFeatures,e,"bServerSide");p(g.oFeatures,e,"bDeferRender");p(g.oScroll,e,"sScrollX","sX");p(g.oScroll,e,"sScrollXInner","sXInner");p(g.oScroll,e,"sScrollY","sY");p(g.oScroll,e,"bScrollCollapse","bCollapse");p(g.oScroll,e,"bScrollInfinite","bInfinite");p(g.oScroll,e,"iScrollLoadGap","iLoadGap");p(g.oScroll,e,"bScrollAutoCss","bAutoCss");p(g,e,"asStripeClasses");p(g,e,"asStripClasses","asStripeClasses");p(g,e,"fnServerData");p(g,e,"fnFormatNumber");p(g,e,"sServerMethod");p(g,e,"aaSorting");p(g,
e,"aaSortingFixed");p(g,e,"aLengthMenu");p(g,e,"sPaginationType");p(g,e,"sAjaxSource");p(g,e,"sAjaxDataProp");p(g,e,"iCookieDuration");p(g,e,"sCookiePrefix");p(g,e,"sDom");p(g,e,"bSortCellsTop");p(g,e,"iTabIndex");p(g,e,"oSearch","oPreviousSearch");p(g,e,"aoSearchCols","aoPreSearchCols");p(g,e,"iDisplayLength","_iDisplayLength");p(g,e,"bJQueryUI","bJUI");p(g,e,"fnCookieCallback");p(g,e,"fnStateLoad");p(g,e,"fnStateSave");p(g.oLanguage,e,"fnInfoCallback");z(g,"aoDrawCallback",e.fnDrawCallback,"user");
z(g,"aoServerParams",e.fnServerParams,"user");z(g,"aoStateSaveParams",e.fnStateSaveParams,"user");z(g,"aoStateLoadParams",e.fnStateLoadParams,"user");z(g,"aoStateLoaded",e.fnStateLoaded,"user");z(g,"aoRowCallback",e.fnRowCallback,"user");z(g,"aoRowCreatedCallback",e.fnCreatedRow,"user");z(g,"aoHeaderCallback",e.fnHeaderCallback,"user");z(g,"aoFooterCallback",e.fnFooterCallback,"user");z(g,"aoInitComplete",e.fnInitComplete,"user");z(g,"aoPreDrawCallback",e.fnPreDrawCallback,"user");g.oFeatures.bServerSide&&
g.oFeatures.bSort&&g.oFeatures.bSortClasses?z(g,"aoDrawCallback",P,"server_side_sort_classes"):g.oFeatures.bDeferRender&&z(g,"aoDrawCallback",P,"defer_sort_classes");e.bJQueryUI?(h.extend(g.oClasses,j.ext.oJUIClasses),e.sDom===j.defaults.sDom&&"lfrtip"===j.defaults.sDom&&(g.sDom='<"H"lfr>t<"F"ip>')):h.extend(g.oClasses,j.ext.oStdClasses);h(this).addClass(g.oClasses.sTable);if(""!==g.oScroll.sX||""!==g.oScroll.sY)g.oScroll.iBarWidth=Qa();g.iInitDisplayStart===n&&(g.iInitDisplayStart=e.iDisplayStart,
g._iDisplayStart=e.iDisplayStart);e.bStateSave&&(g.oFeatures.bStateSave=!0,Sa(g,e),z(g,"aoDrawCallback",ra,"state_save"));null!==e.iDeferLoading&&(g.bDeferLoading=!0,a=h.isArray(e.iDeferLoading),g._iRecordsDisplay=a?e.iDeferLoading[0]:e.iDeferLoading,g._iRecordsTotal=a?e.iDeferLoading[1]:e.iDeferLoading);null!==e.aaData&&(f=!0);""!==e.oLanguage.sUrl?(g.oLanguage.sUrl=e.oLanguage.sUrl,h.getJSON(g.oLanguage.sUrl,null,function(a){pa(a);h.extend(true,g.oLanguage,e.oLanguage,a);ba(g)}),i=!0):h.extend(!0,
g.oLanguage,e.oLanguage);null===e.asStripeClasses&&(g.asStripeClasses=[g.oClasses.sStripeOdd,g.oClasses.sStripeEven]);b=g.asStripeClasses.length;g.asDestroyStripes=[];if(b){c=!1;d=h(this).children("tbody").children("tr:lt("+b+")");for(a=0;a<b;a++)d.hasClass(g.asStripeClasses[a])&&(c=!0,g.asDestroyStripes.push(g.asStripeClasses[a]));c&&d.removeClass(g.asStripeClasses.join(" "))}c=[];a=this.getElementsByTagName("thead");0!==a.length&&(V(g.aoHeader,a[0]),c=N(g));if(null===e.aoColumns){d=[];a=0;for(b=
c.length;a<b;a++)d.push(null)}else d=e.aoColumns;a=0;for(b=d.length;a<b;a++)e.saved_aoColumns!==n&&e.saved_aoColumns.length==b&&(null===d[a]&&(d[a]={}),d[a].bVisible=e.saved_aoColumns[a].bVisible),o(g,c?c[a]:null);ta(g,e.aoColumnDefs,d,function(a,b){m(g,a,b)});a=0;for(b=g.aaSorting.length;a<b;a++){g.aaSorting[a][0]>=g.aoColumns.length&&(g.aaSorting[a][0]=0);var k=g.aoColumns[g.aaSorting[a][0]];g.aaSorting[a][2]===n&&(g.aaSorting[a][2]=0);e.aaSorting===n&&g.saved_aaSorting===n&&(g.aaSorting[a][1]=
k.asSorting[0]);c=0;for(d=k.asSorting.length;c<d;c++)if(g.aaSorting[a][1]==k.asSorting[c]){g.aaSorting[a][2]=c;break}}P(g);Ua(g);a=h(this).children("caption").each(function(){this._captionSide=h(this).css("caption-side")});b=h(this).children("thead");0===b.length&&(b=[l.createElement("thead")],this.appendChild(b[0]));g.nTHead=b[0];b=h(this).children("tbody");0===b.length&&(b=[l.createElement("tbody")],this.appendChild(b[0]));g.nTBody=b[0];g.nTBody.setAttribute("role","alert");g.nTBody.setAttribute("aria-live",
"polite");g.nTBody.setAttribute("aria-relevant","all");b=h(this).children("tfoot");if(0===b.length&&0<a.length&&(""!==g.oScroll.sX||""!==g.oScroll.sY))b=[l.createElement("tfoot")],this.appendChild(b[0]);0<b.length&&(g.nTFoot=b[0],V(g.aoFooter,g.nTFoot));if(f)for(a=0;a<e.aaData.length;a++)H(g,e.aaData[a]);else ua(g);g.aiDisplay=g.aiDisplayMaster.slice();g.bInitialised=!0;!1===i&&ba(g)}});ca=null;return this};j.fnVersionCheck=function(e){for(var h=function(e,h){for(;e.length<h;)e+="0";return e},m=j.ext.sVersion.split("."),
e=e.split("."),k="",n="",l=0,t=e.length;l<t;l++)k+=h(m[l],3),n+=h(e[l],3);return parseInt(k,10)>=parseInt(n,10)};j.fnIsDataTable=function(e){for(var h=j.settings,m=0;m<h.length;m++)if(h[m].nTable===e||h[m].nScrollHead===e||h[m].nScrollFoot===e)return!0;return!1};j.fnTables=function(e){var o=[];jQuery.each(j.settings,function(j,k){(!e||!0===e&&h(k.nTable).is(":visible"))&&o.push(k.nTable)});return o};j.version="1.9.4";j.settings=[];j.models={};j.models.ext={afnFiltering:[],afnSortData:[],aoFeatures:[],
aTypes:[],fnVersionCheck:j.fnVersionCheck,iApiIndex:0,ofnSearch:{},oApi:{},oStdClasses:{},oJUIClasses:{},oPagination:{},oSort:{},sVersion:j.version,sErrMode:"alert",_oExternConfig:{iNextUnique:0}};j.models.oSearch={bCaseInsensitive:!0,sSearch:"",bRegex:!1,bSmart:!0};j.models.oRow={nTr:null,_aData:[],_aSortData:[],_anHidden:[],_sRowStripe:""};j.models.oColumn={aDataSort:null,asSorting:null,bSearchable:null,bSortable:null,bUseRendered:null,bVisible:null,_bAutoType:!0,fnCreatedCell:null,fnGetData:null,
fnRender:null,fnSetData:null,mData:null,mRender:null,nTh:null,nTf:null,sClass:null,sContentPadding:null,sDefaultContent:null,sName:null,sSortDataType:"std",sSortingClass:null,sSortingClassJUI:null,sTitle:null,sType:null,sWidth:null,sWidthOrig:null};j.defaults={aaData:null,aaSorting:[[0,"asc"]],aaSortingFixed:null,aLengthMenu:[10,25,50,100],aoColumns:null,aoColumnDefs:null,aoSearchCols:[],asStripeClasses:null,bAutoWidth:!0,bDeferRender:!1,bDestroy:!1,bFilter:!0,bInfo:!0,bJQueryUI:!1,bLengthChange:!0,
bPaginate:!0,bProcessing:!1,bRetrieve:!1,bScrollAutoCss:!0,bScrollCollapse:!1,bScrollInfinite:!1,bServerSide:!1,bSort:!0,bSortCellsTop:!1,bSortClasses:!0,bStateSave:!1,fnCookieCallback:null,fnCreatedRow:null,fnDrawCallback:null,fnFooterCallback:null,fnFormatNumber:function(e){if(1E3>e)return e;for(var h=e+"",e=h.split(""),j="",h=h.length,k=0;k<h;k++)0===k%3&&0!==k&&(j=this.oLanguage.sInfoThousands+j),j=e[h-k-1]+j;return j},fnHeaderCallback:null,fnInfoCallback:null,fnInitComplete:null,fnPreDrawCallback:null,
fnRowCallback:null,fnServerData:function(e,j,m,k){k.jqXHR=h.ajax({url:e,data:j,success:function(e){e.sError&&k.oApi._fnLog(k,0,e.sError);h(k.oInstance).trigger("xhr",[k,e]);m(e)},dataType:"json",cache:!1,type:k.sServerMethod,error:function(e,h){"parsererror"==h&&k.oApi._fnLog(k,0,"DataTables warning: JSON data from server could not be parsed. This is caused by a JSON formatting error.")}})},fnServerParams:null,fnStateLoad:function(e){var e=this.oApi._fnReadCookie(e.sCookiePrefix+e.sInstance),j;try{j=
"function"===typeof h.parseJSON?h.parseJSON(e):eval("("+e+")")}catch(m){j=null}return j},fnStateLoadParams:null,fnStateLoaded:null,fnStateSave:function(e,h){this.oApi._fnCreateCookie(e.sCookiePrefix+e.sInstance,this.oApi._fnJsonString(h),e.iCookieDuration,e.sCookiePrefix,e.fnCookieCallback)},fnStateSaveParams:null,iCookieDuration:7200,iDeferLoading:null,iDisplayLength:10,iDisplayStart:0,iScrollLoadGap:100,iTabIndex:0,oLanguage:{oAria:{sSortAscending:": activate to sort column ascending",sSortDescending:": activate to sort column descending"},
oPaginate:{sFirst:"First",sLast:"Last",sNext:"Next",sPrevious:"Previous"},sEmptyTable:"No data available in table",sInfo:"Showing _START_ to _END_ of _TOTAL_ entries",sInfoEmpty:"Showing 0 to 0 of 0 entries",sInfoFiltered:"(filtered from _MAX_ total entries)",sInfoPostFix:"",sInfoThousands:",",sLengthMenu:"Show _MENU_ entries",sLoadingRecords:"Loading...",sProcessing:"Processing...",sSearch:"Search:",sUrl:"",sZeroRecords:"No matching records found"},oSearch:h.extend({},j.models.oSearch),sAjaxDataProp:"aaData",
sAjaxSource:null,sCookiePrefix:"SpryMedia_DataTables_",sDom:"lfrtip",sPaginationType:"two_button",sScrollX:"",sScrollXInner:"",sScrollY:"",sServerMethod:"GET"};j.defaults.columns={aDataSort:null,asSorting:["asc","desc"],bSearchable:!0,bSortable:!0,bUseRendered:!0,bVisible:!0,fnCreatedCell:null,fnRender:null,iDataSort:-1,mData:null,mRender:null,sCellType:"td",sClass:"",sContentPadding:"",sDefaultContent:null,sName:"",sSortDataType:"std",sTitle:null,sType:null,sWidth:null};j.models.oSettings={oFeatures:{bAutoWidth:null,
bDeferRender:null,bFilter:null,bInfo:null,bLengthChange:null,bPaginate:null,bProcessing:null,bServerSide:null,bSort:null,bSortClasses:null,bStateSave:null},oScroll:{bAutoCss:null,bCollapse:null,bInfinite:null,iBarWidth:0,iLoadGap:null,sX:null,sXInner:null,sY:null},oLanguage:{fnInfoCallback:null},oBrowser:{bScrollOversize:!1},aanFeatures:[],aoData:[],aiDisplay:[],aiDisplayMaster:[],aoColumns:[],aoHeader:[],aoFooter:[],asDataSearch:[],oPreviousSearch:{},aoPreSearchCols:[],aaSorting:null,aaSortingFixed:null,
asStripeClasses:null,asDestroyStripes:[],sDestroyWidth:0,aoRowCallback:[],aoHeaderCallback:[],aoFooterCallback:[],aoDrawCallback:[],aoRowCreatedCallback:[],aoPreDrawCallback:[],aoInitComplete:[],aoStateSaveParams:[],aoStateLoadParams:[],aoStateLoaded:[],sTableId:"",nTable:null,nTHead:null,nTFoot:null,nTBody:null,nTableWrapper:null,bDeferLoading:!1,bInitialised:!1,aoOpenRows:[],sDom:null,sPaginationType:"two_button",iCookieDuration:0,sCookiePrefix:"",fnCookieCallback:null,aoStateSave:[],aoStateLoad:[],
oLoadedState:null,sAjaxSource:null,sAjaxDataProp:null,bAjaxDataGet:!0,jqXHR:null,fnServerData:null,aoServerParams:[],sServerMethod:null,fnFormatNumber:null,aLengthMenu:null,iDraw:0,bDrawing:!1,iDrawError:-1,_iDisplayLength:10,_iDisplayStart:0,_iDisplayEnd:10,_iRecordsTotal:0,_iRecordsDisplay:0,bJUI:null,oClasses:{},bFiltered:!1,bSorted:!1,bSortCellsTop:null,oInit:null,aoDestroyCallback:[],fnRecordsTotal:function(){return this.oFeatures.bServerSide?parseInt(this._iRecordsTotal,10):this.aiDisplayMaster.length},
fnRecordsDisplay:function(){return this.oFeatures.bServerSide?parseInt(this._iRecordsDisplay,10):this.aiDisplay.length},fnDisplayEnd:function(){return this.oFeatures.bServerSide?!1===this.oFeatures.bPaginate||-1==this._iDisplayLength?this._iDisplayStart+this.aiDisplay.length:Math.min(this._iDisplayStart+this._iDisplayLength,this._iRecordsDisplay):this._iDisplayEnd},oInstance:null,sInstance:null,iTabIndex:0,nScrollHead:null,nScrollFoot:null};j.ext=h.extend(!0,{},j.models.ext);h.extend(j.ext.oStdClasses,
{sTable:"dataTable",sPagePrevEnabled:"paginate_enabled_previous",sPagePrevDisabled:"paginate_disabled_previous",sPageNextEnabled:"paginate_enabled_next",sPageNextDisabled:"paginate_disabled_next",sPageJUINext:"",sPageJUIPrev:"",sPageButton:"paginate_button",sPageButtonActive:"paginate_active",sPageButtonStaticDisabled:"paginate_button paginate_button_disabled",sPageFirst:"first",sPagePrevious:"previous",sPageNext:"next",sPageLast:"last",sStripeOdd:"odd",sStripeEven:"even",sRowEmpty:"dataTables_empty",
sWrapper:"dataTables_wrapper",sFilter:"dataTables_filter",sInfo:"dataTables_info",sPaging:"dataTables_paginate paging_",sLength:"dataTables_length",sProcessing:"dataTables_processing",sSortAsc:"sorting_asc",sSortDesc:"sorting_desc",sSortable:"sorting",sSortableAsc:"sorting_asc_disabled",sSortableDesc:"sorting_desc_disabled",sSortableNone:"sorting_disabled",sSortColumn:"sorting_",sSortJUIAsc:"",sSortJUIDesc:"",sSortJUI:"",sSortJUIAscAllowed:"",sSortJUIDescAllowed:"",sSortJUIWrapper:"",sSortIcon:"",
sScrollWrapper:"dataTables_scroll",sScrollHead:"dataTables_scrollHead",sScrollHeadInner:"dataTables_scrollHeadInner",sScrollBody:"dataTables_scrollBody",sScrollFoot:"dataTables_scrollFoot",sScrollFootInner:"dataTables_scrollFootInner",sFooterTH:"",sJUIHeader:"",sJUIFooter:""});h.extend(j.ext.oJUIClasses,j.ext.oStdClasses,{sPagePrevEnabled:"fg-button ui-button ui-state-default ui-corner-left",sPagePrevDisabled:"fg-button ui-button ui-state-default ui-corner-left ui-state-disabled",sPageNextEnabled:"fg-button ui-button ui-state-default ui-corner-right",
sPageNextDisabled:"fg-button ui-button ui-state-default ui-corner-right ui-state-disabled",sPageJUINext:"ui-icon ui-icon-circle-arrow-e",sPageJUIPrev:"ui-icon ui-icon-circle-arrow-w",sPageButton:"fg-button ui-button ui-state-default",sPageButtonActive:"fg-button ui-button ui-state-default ui-state-disabled",sPageButtonStaticDisabled:"fg-button ui-button ui-state-default ui-state-disabled",sPageFirst:"first ui-corner-tl ui-corner-bl",sPageLast:"last ui-corner-tr ui-corner-br",sPaging:"dataTables_paginate fg-buttonset ui-buttonset fg-buttonset-multi ui-buttonset-multi paging_",
sSortAsc:"ui-state-default",sSortDesc:"ui-state-default",sSortable:"ui-state-default",sSortableAsc:"ui-state-default",sSortableDesc:"ui-state-default",sSortableNone:"ui-state-default",sSortJUIAsc:"css_right ui-icon ui-icon-triangle-1-n",sSortJUIDesc:"css_right ui-icon ui-icon-triangle-1-s",sSortJUI:"css_right ui-icon ui-icon-carat-2-n-s",sSortJUIAscAllowed:"css_right ui-icon ui-icon-carat-1-n",sSortJUIDescAllowed:"css_right ui-icon ui-icon-carat-1-s",sSortJUIWrapper:"DataTables_sort_wrapper",sSortIcon:"DataTables_sort_icon",
sScrollHead:"dataTables_scrollHead ui-state-default",sScrollFoot:"dataTables_scrollFoot ui-state-default",sFooterTH:"ui-state-default",sJUIHeader:"fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix",sJUIFooter:"fg-toolbar ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix"});h.extend(j.ext.oPagination,{two_button:{fnInit:function(e,j,m){var k=e.oLanguage.oPaginate,n=function(h){e.oApi._fnPageChange(e,h.data.action)&&m(e)},k=!e.bJUI?'<a class="'+
e.oClasses.sPagePrevDisabled+'" tabindex="'+e.iTabIndex+'" role="button">'+k.sPrevious+'</a><a class="'+e.oClasses.sPageNextDisabled+'" tabindex="'+e.iTabIndex+'" role="button">'+k.sNext+"</a>":'<a class="'+e.oClasses.sPagePrevDisabled+'" tabindex="'+e.iTabIndex+'" role="button"><span class="'+e.oClasses.sPageJUIPrev+'"></span></a><a class="'+e.oClasses.sPageNextDisabled+'" tabindex="'+e.iTabIndex+'" role="button"><span class="'+e.oClasses.sPageJUINext+'"></span></a>';h(j).append(k);var l=h("a",j),
k=l[0],l=l[1];e.oApi._fnBindAction(k,{action:"previous"},n);e.oApi._fnBindAction(l,{action:"next"},n);e.aanFeatures.p||(j.id=e.sTableId+"_paginate",k.id=e.sTableId+"_previous",l.id=e.sTableId+"_next",k.setAttribute("aria-controls",e.sTableId),l.setAttribute("aria-controls",e.sTableId))},fnUpdate:function(e){if(e.aanFeatures.p)for(var h=e.oClasses,j=e.aanFeatures.p,k,l=0,n=j.length;l<n;l++)if(k=j[l].firstChild)k.className=0===e._iDisplayStart?h.sPagePrevDisabled:h.sPagePrevEnabled,k=k.nextSibling,
k.className=e.fnDisplayEnd()==e.fnRecordsDisplay()?h.sPageNextDisabled:h.sPageNextEnabled}},iFullNumbersShowPages:5,full_numbers:{fnInit:function(e,j,m){var k=e.oLanguage.oPaginate,l=e.oClasses,n=function(h){e.oApi._fnPageChange(e,h.data.action)&&m(e)};h(j).append('<a  tabindex="'+e.iTabIndex+'" class="'+l.sPageButton+" "+l.sPageFirst+'">'+k.sFirst+'</a><a  tabindex="'+e.iTabIndex+'" class="'+l.sPageButton+" "+l.sPagePrevious+'">'+k.sPrevious+'</a><span></span><a tabindex="'+e.iTabIndex+'" class="'+
l.sPageButton+" "+l.sPageNext+'">'+k.sNext+'</a><a tabindex="'+e.iTabIndex+'" class="'+l.sPageButton+" "+l.sPageLast+'">'+k.sLast+"</a>");var t=h("a",j),k=t[0],l=t[1],r=t[2],t=t[3];e.oApi._fnBindAction(k,{action:"first"},n);e.oApi._fnBindAction(l,{action:"previous"},n);e.oApi._fnBindAction(r,{action:"next"},n);e.oApi._fnBindAction(t,{action:"last"},n);e.aanFeatures.p||(j.id=e.sTableId+"_paginate",k.id=e.sTableId+"_first",l.id=e.sTableId+"_previous",r.id=e.sTableId+"_next",t.id=e.sTableId+"_last")},
fnUpdate:function(e,o){if(e.aanFeatures.p){var m=j.ext.oPagination.iFullNumbersShowPages,k=Math.floor(m/2),l=Math.ceil(e.fnRecordsDisplay()/e._iDisplayLength),n=Math.ceil(e._iDisplayStart/e._iDisplayLength)+1,t="",r,B=e.oClasses,u,M=e.aanFeatures.p,L=function(h){e.oApi._fnBindAction(this,{page:h+r-1},function(h){e.oApi._fnPageChange(e,h.data.page);o(e);h.preventDefault()})};-1===e._iDisplayLength?n=k=r=1:l<m?(r=1,k=l):n<=k?(r=1,k=m):n>=l-k?(r=l-m+1,k=l):(r=n-Math.ceil(m/2)+1,k=r+m-1);for(m=r;m<=k;m++)t+=
n!==m?'<a tabindex="'+e.iTabIndex+'" class="'+B.sPageButton+'">'+e.fnFormatNumber(m)+"</a>":'<a tabindex="'+e.iTabIndex+'" class="'+B.sPageButtonActive+'">'+e.fnFormatNumber(m)+"</a>";m=0;for(k=M.length;m<k;m++)u=M[m],u.hasChildNodes()&&(h("span:eq(0)",u).html(t).children("a").each(L),u=u.getElementsByTagName("a"),u=[u[0],u[1],u[u.length-2],u[u.length-1]],h(u).removeClass(B.sPageButton+" "+B.sPageButtonActive+" "+B.sPageButtonStaticDisabled),h([u[0],u[1]]).addClass(1==n?B.sPageButtonStaticDisabled:
B.sPageButton),h([u[2],u[3]]).addClass(0===l||n===l||-1===e._iDisplayLength?B.sPageButtonStaticDisabled:B.sPageButton))}}}});h.extend(j.ext.oSort,{"string-pre":function(e){"string"!=typeof e&&(e=null!==e&&e.toString?e.toString():"");return e.toLowerCase()},"string-asc":function(e,h){return e<h?-1:e>h?1:0},"string-desc":function(e,h){return e<h?1:e>h?-1:0},"html-pre":function(e){return e.replace(/<.*?>/g,"").toLowerCase()},"html-asc":function(e,h){return e<h?-1:e>h?1:0},"html-desc":function(e,h){return e<
h?1:e>h?-1:0},"date-pre":function(e){e=Date.parse(e);if(isNaN(e)||""===e)e=Date.parse("01/01/1970 00:00:00");return e},"date-asc":function(e,h){return e-h},"date-desc":function(e,h){return h-e},"numeric-pre":function(e){return"-"==e||""===e?0:1*e},"numeric-asc":function(e,h){return e-h},"numeric-desc":function(e,h){return h-e}});h.extend(j.ext.aTypes,[function(e){if("number"===typeof e)return"numeric";if("string"!==typeof e)return null;var h,j=!1;h=e.charAt(0);if(-1=="0123456789-".indexOf(h))return null;
for(var k=1;k<e.length;k++){h=e.charAt(k);if(-1=="0123456789.".indexOf(h))return null;if("."==h){if(j)return null;j=!0}}return"numeric"},function(e){var h=Date.parse(e);return null!==h&&!isNaN(h)||"string"===typeof e&&0===e.length?"date":null},function(e){return"string"===typeof e&&-1!=e.indexOf("<")&&-1!=e.indexOf(">")?"html":null}]);h.fn.DataTable=j;h.fn.dataTable=j;h.fn.dataTableSettings=j.settings;h.fn.dataTableExt=j.ext};"function"===typeof define&&define.amd?define(["jquery"],L):jQuery&&!jQuery.fn.dataTable&&
L(jQuery)})(window,document);
$.extend(!0,$.fn.dataTable.defaults,{sDom:"<'row'<'col-xs-6'l><'col-xs-6'f>r>t<'row'<'col-xs-6'i><'col-xs-6'p>>",oLanguage:{sLengthMenu:"Display _MENU_ records"}}),$.extend($.fn.dataTableExt.oStdClasses,{sWrapper:"dataTables_wrapper form-inline",sFilterInput:"form-control input-sm",sLengthSelect:"form-control input-sm"}),$.fn.dataTable.Api?($.fn.dataTable.defaults.renderer="bootstrap",$.fn.dataTable.ext.renderer.pageButton.bootstrap=function(a,b,c,d,e,f){var g,h,i=new $.fn.dataTable.Api(a),j=a.oClasses,k=a.oLanguage.oPaginate,l=function(b,d){var m,n,o,p,q=function(a){return a.preventDefault(),$(a.target).parent().hasClass("disabled")?!1:void("ellipsis"!==a.data.action&&i.page(a.data.action).draw(!1))};for(m=0,n=d.length;n>m;m++)if(p=d[m],$.isArray(p))l(b,p);else{switch(g="",h="",p){case"ellipsis":g="&hellip;",h="disabled";break;case"first":g=k.sFirst,h=p+(e>0?"":" disabled");break;case"previous":g=k.sPrevious,h=p+(e>0?"":" disabled");break;case"next":g=k.sNext,h=p+(f-1>e?"":" disabled");break;case"last":g=k.sLast,h=p+(f-1>e?"":" disabled");break;default:g=p+1,h=e===p?"active":""}g&&(o=$("<li>",{"class":j.sPageButton+" "+h,"aria-controls":a.sTableId,tabindex:a.iTabIndex,id:0===c&&"string"==typeof p?a.sTableId+"_"+p:null}).append($("<a>",{href:"#"}).html(g)).appendTo(b),a.oApi._fnBindAction(o,{action:p},q))}};l($(b).empty().html('<ul class="pagination"/>').children("ul"),d)}):($.fn.dataTable.defaults.sPaginationType="bootstrap",$.fn.dataTableExt.oApi.fnPagingInfo=function(a){return{iStart:a._iDisplayStart,iEnd:a.fnDisplayEnd(),iLength:a._iDisplayLength,iTotal:a.fnRecordsTotal(),iFilteredTotal:a.fnRecordsDisplay(),iPage:-1===a._iDisplayLength?0:Math.ceil(a._iDisplayStart/a._iDisplayLength),iTotalPages:-1===a._iDisplayLength?0:Math.ceil(a.fnRecordsDisplay()/a._iDisplayLength)}},$.extend($.fn.dataTableExt.oPagination,{bootstrap:{fnInit:function(a,b,c){var d=(a.oLanguage.oPaginate,function(b){alert(1),b.preventDefault(),a.oApi._fnPageChange(a,b.data.action)&&c(a)});$(b).append('<ul class="pagination"><li class="prev disabled"><a href="#"><i class="fa fa-angle-double-left"></i></a></li><li class="prev disabled"><a href="#"><i class="fa fa-angle-left"></i></a></li><li class="next disabled"><a href="#"><i class="fa fa-angle-right"></i></a></li><li class="next disabled"><a href="#"><i class="fa fa-angle-double-right"></i></a></li></ul>');var e=$("a",b);$(e[0]).bind("click.DT",{action:"first"},d),$(e[1]).bind("click.DT",{action:"previous"},d),$(e[2]).bind("click.DT",{action:"next"},d),$(e[3]).bind("click.DT",{action:"last"},d)},fnUpdate:function(a,b){var c,d,e,f,g,h,i=5,j=a.oInstance.fnPagingInfo(),k=a.aanFeatures.p,l=Math.floor(i/2);for(j.iTotalPages<i?(g=1,h=j.iTotalPages):j.iPage<=l?(g=1,h=i):j.iPage>=j.iTotalPages-l?(g=j.iTotalPages-i+1,h=j.iTotalPages):(g=j.iPage-l+1,h=g+i-1),c=0,d=k.length;d>c;c++){for($("li:gt(0)",k[c]).filter(":not(.next,.prev)").remove(),e=g;h>=e;e++)f=e==j.iPage+1?'class="active"':"",$("<li "+f+'><a href="#">'+e+"</a></li>").insertBefore($("li.next:eq(0)",k[c])[0]).bind("click",function(c){c.preventDefault(),a._iDisplayStart=(parseInt($("a",this).text(),10)-1)*j.iLength,b(a)});0===j.iPage?$("li.prev",k[c]).addClass("disabled"):$("li.prev",k[c]).removeClass("disabled"),j.iPage===j.iTotalPages-1||0===j.iTotalPages?$("li.next",k[c]).addClass("disabled"):$("li.next",k[c]).removeClass("disabled")}}}})),$.fn.DataTable.TableTools&&($.extend(!0,$.fn.DataTable.TableTools.classes,{container:"DTTT btn-group",buttons:{normal:"btn btn-default",disabled:"disabled"},collection:{container:"DTTT_dropdown dropdown-menu",buttons:{normal:"",disabled:"disabled"}},print:{info:"DTTT_print_info modal"},select:{row:"active"}}),$.extend(!0,$.fn.DataTable.TableTools.DEFAULTS.oTags,{collection:{container:"ul",button:"li",liner:"a"}}));
(function() {
  var crearDataTable;

  crearDataTable = function(selector) {
    return $(selector).DataTable({
      language: {
        url: "/assets/dataTables.Spanish.txt"
      }
    });
  };

  $(document).ready(function() {
    $('select#empleado_id').select2({});
    $('select#horario_empleado_id').select2({});
    $('select#empleado_proyecto_id').select2({});
    $("#horario_empleado_id").chained("#empleado_id");
    $("#empleado_proyecto_id").chained("#empleado_id");
    crearDataTable("#check-outs");
  });

}).call(this);
