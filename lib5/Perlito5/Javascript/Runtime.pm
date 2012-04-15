# Do not edit this file - Generated by Perlito5 9.0
use v5;
use Perlito5::Perl5::Runtime;
package main;
use v5;
package Perlito5::Javascript::Runtime;
sub Perlito5::Javascript::Runtime::emit_javascript {
    return ((('//' . chr(10) . '// lib/Perlito5/Javascript/Runtime.js' . chr(10) . '//' . chr(10) . '// Runtime for "Perlito" Perl5-in-Javascript' . chr(10) . '//' . chr(10) . '// AUTHORS' . chr(10) . '//' . chr(10) . '// Flavio Soibelmann Glock  fglock@gmail.com' . chr(10) . '//' . chr(10) . '// COPYRIGHT' . chr(10) . '//' . chr(10) . '// Copyright 2009, 2010, 2011, 2012 by Flavio Soibelmann Glock and others.' . chr(10) . '//' . chr(10) . '// This program is free software; you can redistribute it and/or modify it' . chr(10) . '// under the same terms as Perl itself.' . chr(10) . '//' . chr(10) . '// See http://www.perl.com/perl/misc/Artistic.html' . chr(10) . chr(10) . 'var isNode = typeof require != "undefined";' . chr(10) . chr(10) . 'if (typeof p5pkg !== "object") {' . chr(10) . '    p5pkg = {};' . chr(10) . '    p5LOCAL = [];' . chr(10) . chr(10) . '    var universal = function () {};' . chr(10) . '    p5pkg.UNIVERSAL = new universal();' . chr(10) . '    p5pkg.UNIVERSAL._ref_ = "UNIVERSAL";' . chr(10) . '    p5pkg.UNIVERSAL.isa = function (List__) {' . chr(10) . '        // TODO - use @ISA' . chr(10) . '        return List__[0]._class_._ref_ == List__[1]' . chr(10) . '    };' . chr(10) . '    p5pkg.UNIVERSAL.can = function (List__) {' . chr(10) . '        var o = List__[0];' . chr(10) . '        var s = List__[1];' . chr(10) . '        if ( s.indexOf("::") == -1 ) {' . chr(10) . '            // TODO - use p5method_lookup' . chr(10) . '            return o._class_[s]' . chr(10) . '        }' . chr(10) . '        var c = s.split("::");' . chr(10) . '        s = c.pop(); ' . chr(10) . '        // TODO - use p5method_lookup' . chr(10) . '        return p5method_lookup(s, c.join("::"), {});' . chr(10) . '    };' . chr(10) . '    p5pkg.UNIVERSAL.DOES = p5pkg.UNIVERSAL.can;' . chr(10) . chr(10) . '    var core = function () {};' . chr(10) . '    p5pkg["CORE"] = new core();' . chr(10) . '    p5pkg["CORE"]._ref_ = "CORE";' . chr(10) . chr(10) . '    var core_global = function () {};' . chr(10) . '    core_global.prototype = p5pkg.CORE;' . chr(10) . '    p5pkg["CORE::GLOBAL"] = new core_global();' . chr(10) . '    p5pkg["CORE::GLOBAL"]._ref_ = "CORE::GLOBAL";' . chr(10) . chr(10) . '    p5_error = function (v) {' . chr(10) . '        this.v = v;' . chr(10) . '        this.toString = function(){ return this.v };' . chr(10) . '    };' . chr(10) . '    p5_error.prototype = Error.prototype;' . chr(10) . '}' . chr(10) . chr(10) . 'function p5make_package(pkg_name) {' . chr(10) . '    if (!p5pkg.hasOwnProperty(pkg_name)) {' . chr(10) . '        var tmp = function () {};' . chr(10) . '        tmp.prototype = p5pkg["CORE::GLOBAL"];' . chr(10) . '        p5pkg[pkg_name] = new tmp();' . chr(10) . '        p5pkg[pkg_name]._ref_ = pkg_name;' . chr(10) . '        p5pkg[pkg_name]._class_ = p5pkg[pkg_name];  // XXX memory leak' . chr(10) . chr(10) . '        // TODO - add the other package global variables' . chr(10) . '        p5pkg[pkg_name]["List_ISA"] = [];' . chr(10) . '        p5pkg[pkg_name]["v_a"] = null;' . chr(10) . '        p5pkg[pkg_name]["v_b"] = null;' . chr(10) . '        p5pkg[pkg_name]["v__"] = null;' . chr(10) . '    }' . chr(10) . '    return p5pkg[pkg_name];' . chr(10) . '}' . chr(10) . chr(10) . 'function p5code_lookup_by_name(package, sub_name) {' . chr(10) . '    // sub_name can have an optional namespace' . chr(10) . '    var parts = sub_name.split(/::/);' . chr(10) . '    if (parts.length > 1) {' . chr(10) . '        sub_name = parts.pop();' . chr(10) . '        package = parts.join("::");' . chr(10) . '    }' . chr(10) . '    if (p5pkg.hasOwnProperty(package)) {' . chr(10) . '        var c = p5pkg[package];' . chr(10) . '        if ( c.hasOwnProperty(sub_name) ) {' . chr(10) . '            return c[sub_name]' . chr(10) . '        }' . chr(10) . '    }' . chr(10) . '    return null;' . chr(10) . '}' . chr(10) . chr(10) . 'function p5method_lookup(method, class_name, seen) {' . chr(10) . '    // default mro' . chr(10) . '    var c = p5pkg[class_name];' . chr(10) . '    if ( c.hasOwnProperty(method) ) {' . chr(10) . '        return c[method]' . chr(10) . '    }' . chr(10) . '    var isa = c.List_ISA;' . chr(10) . '    for (var i = 0; i < isa.length; i++) {' . chr(10) . '        if (!seen[isa[i]]) {' . chr(10) . '            var m = p5method_lookup(method, isa[i]);' . chr(10) . '            if (m) {' . chr(10) . '                return m ' . chr(10) . '            }' . chr(10) . '            seen[isa[i]]++;' . chr(10) . '        }' . chr(10) . '    }' . chr(10) . '    // TODO - AUTOLOAD' . chr(10) . '}' . chr(10) . chr(10) . 'function p5call(invocant, method, list) {' . chr(10) . '    list.unshift(invocant);' . chr(10) . chr(10) . '    if ( invocant.hasOwnProperty("_class_") ) {' . chr(10) . chr(10) . '        if ( invocant._class_.hasOwnProperty(method) ) {' . chr(10) . '            return invocant._class_[method](list)' . chr(10) . '        }' . chr(10) . '        var m = p5method_lookup(method, invocant._class_._ref_, {});' . chr(10) . '        if (m) {' . chr(10) . '            return m(list)' . chr(10) . '        }' . chr(10) . '        if ( p5pkg.UNIVERSAL.hasOwnProperty(method) ) {' . chr(10) . '            return p5pkg.UNIVERSAL[method](list)' . chr(10) . '        }' . chr(10) . chr(10) . '        // method can have an optional namespace' . chr(10) . '        var package = method.split(/::/);' . chr(10) . '        if (package.length > 1) {' . chr(10) . '            var name = package.pop();' . chr(10) . '            package = package.join("::");' . chr(10) . '            m = p5method_lookup(name, package, {});' . chr(10) . '            // CORE.say([ name, " ", package ]);' . chr(10) . '            if (m) {' . chr(10) . '                return m(list)' . chr(10) . '            }' . chr(10) . '            p5pkg.CORE.die(["method not found: ", name, " in class ", package]);' . chr(10) . '        }' . chr(10) . chr(10) . '        // TODO - cache the methods that were already looked up' . chr(10) . '        p5pkg.CORE.die(["method not found: ", method, " in class ", invocant._ref_]);' . chr(10) . chr(10) . '    }' . chr(10) . chr(10) . '    // the invocant doesn' . chr(39) . 't have a class' . chr(10) . chr(10) . '    if (typeof invocant === "string") {' . chr(10) . '        var aclass = p5make_package(invocant);' . chr(10) . '        return p5call(aclass, method, list);' . chr(10) . '    }' . chr(10) . chr(10) . '    p5pkg.CORE.die(["Can' . chr(39) . 't call method ", method, " on unblessed reference"]);' . chr(10) . chr(10) . '}' . chr(10) . chr(10) . 'p5make_package("main");' . chr(10) . 'p5pkg["main"]["v_@"] = [];      // $@' . chr(10) . 'p5pkg["main"]["List_#"] = [];   // @#' . chr(10) . 'p5pkg["main"]["v_^O"] = isNode ? "node.js" : "javascript";' . chr(10) . 'p5pkg["main"]["List_INC"] = [];' . chr(10) . 'p5pkg["main"]["Hash_INC"] = {};' . chr(10) . 'p5pkg["main"]["List_ARGV"] = [];' . chr(10) . 'p5pkg["main"]["Hash_ENV"] = {};' . chr(10) . 'if (isNode) {' . chr(10) . '    p5pkg["main"]["List_ARGV"] = process.argv.splice(2);' . chr(10) . '    p5pkg["main"]["Hash_ENV"]  = process.env;' . chr(10) . '} else if (typeof arguments === "object") {' . chr(10) . '    p5pkg["main"]["List_ARGV"] = arguments;' . chr(10) . '}' . chr(10) . chr(10) . 'p5make_package("Perlito5");' . chr(10) . 'p5make_package("Perlito5::IO");' . chr(10) . 'p5make_package("Perlito5::Runtime");' . chr(10) . 'p5make_package("Perlito5::Grammar");' . chr(10) . chr(10) . 'function p5make_sub(pkg_name, sub_name, func) {' . chr(10) . '    p5pkg[pkg_name][sub_name] = func;' . chr(10) . '}' . chr(10) . chr(10) . 'function p5set_local(namespace, name, sigil) {' . chr(10) . '    var v = name;' . chr(10) . '    if (sigil == "$") {' . chr(10) . '        v = "v_"+name;' . chr(10) . '    }' . chr(10) . '    p5LOCAL.push([namespace, v, namespace[v]]);' . chr(10) . '}' . chr(10) . chr(10) . 'function p5cleanup_local(idx, value) {' . chr(10) . '    while (p5LOCAL.length > idx) {' . chr(10) . '        l = p5LOCAL.pop();' . chr(10) . '        l[0][l[1]] = l[2];' . chr(10) . '    }' . chr(10) . '    return value;' . chr(10) . '}' . chr(10) . chr(10) . 'function p5HashRef(o) {' . chr(10) . '    this._hash_ = o;' . chr(10) . '    this._ref_ = "HASH";' . chr(10) . '    this.bool = function() { return 1 };' . chr(10) . '}' . chr(10) . chr(10) . 'function p5ArrayRef(o) {' . chr(10) . '    this._array_ = o;' . chr(10) . '    this._ref_ = "ARRAY";' . chr(10) . '    this.bool = function() { return 1 };' . chr(10) . '}' . chr(10) . chr(10) . 'function p5ScalarRef(o) {' . chr(10) . '    this._scalar_ = o;' . chr(10) . '    this._ref_ = "SCALAR";' . chr(10) . '    this.bool = function() { return 1 };' . chr(10) . '}' . chr(10) . chr(10) . 'if (isNode) {' . chr(10) . '    var fs = require("fs");' . chr(10) . '    p5make_sub("Perlito5::IO", "slurp", function(List__) {' . chr(10) . '        return fs.readFileSync(List__[0],"utf8");' . chr(10) . '    });' . chr(10) . '} else {' . chr(10) . '    p5make_sub("Perlito5::IO", "slurp", function(List__) {' . chr(10) . '        var filename = List__[0];' . chr(10) . '        if (typeof readFile == "function") {' . chr(10) . '            return readFile(filename);' . chr(10) . '        }' . chr(10) . '        if (typeof read == "function") {' . chr(10) . '            // v8' . chr(10) . '            return read(filename);' . chr(10) . '        }' . chr(10) . '        p5pkg.CORE.die(["Perlito5::IO::slurp() not implemented"]);' . chr(10) . '    });' . chr(10) . '}' . chr(10) . chr(10) . 'p5context = function(List__, p5want) {' . chr(10) . '    if (p5want) {' . chr(10) . '        return p5list_to_a.apply(null, List__);' . chr(10) . '    }' . chr(10) . '    // scalar: return the last value' . chr(10) . '    var o = List__;' . chr(10) . '    while (o instanceof Array) {' . chr(10) . '        o =   o.length' . chr(10) . '            ? o[o.length-1]' . chr(10) . '            : null;' . chr(10) . '    }' . chr(10) . '    return o;' . chr(10) . '}' . chr(10) . chr(10) . 'p5list_to_a = function() {' . chr(10) . '    var res = [];' . chr(10) . '    for (i = 0; i < arguments.length; i++) {' . chr(10) . '        var o = arguments[i];' . chr(10) . '        if  (  o == null' . chr(10) . '            || o._class_    // perl5 blessed reference' . chr(10) . '            || o._ref_      // perl5 un-blessed reference' . chr(10) . '            )' . chr(10) . '        {' . chr(10) . '            res.push(o);' . chr(10) . '        }' . chr(10) . '        else if (o instanceof Array) {' . chr(10) . '            // perl5 array' . chr(10) . '            for (j = 0; j < o.length; j++) {' . chr(10) . '                res.push(o[j]);' . chr(10) . '            }' . chr(10) . '        }' . chr(10) . '        else if (typeof o === "object") {' . chr(10) . '            // perl5 hash' . chr(10) . '            for(var j in o) {' . chr(10) . '                if (o.hasOwnProperty(j)) {' . chr(10) . '                    res.push(j);' . chr(10) . '                    res.push(o[j]);' . chr(10) . '                }' . chr(10) . '            }' . chr(10) . '        }' . chr(10) . '        else {' . chr(10) . '            // non-ref' . chr(10) . '            res.push(o);' . chr(10) . '        }' . chr(10) . '    }' . chr(10) . '    return res;' . chr(10) . '};' . chr(10) . chr(10) . 'p5a_to_h = function(a) {' . chr(10) . '    var res = {};' . chr(10) . '    for (i = 0; i < a.length; i+=2) {' . chr(10) . '        res[p5str(a[i])] = a[i+1];' . chr(10) . '    }' . chr(10) . '    return res;' . chr(10) . '};' . chr(10) . chr(10) . 'p5idx = function(a, i) {' . chr(10) . '    return i >= 0 ? i : a.length + i' . chr(10) . '};' . chr(10) . chr(10) . 'p5str = function(o) {' . chr(10) . '    if (o == null) {' . chr(10) . '        return "";' . chr(10) . '    }' . chr(10) . '    if (typeof o === "object" && (o instanceof Array)) {' . chr(10) . '        return CORE.join(["", o]);' . chr(10) . '    }' . chr(10) . '    // if (typeof o.string === "function") {' . chr(10) . '    //     return o.string();' . chr(10) . '    // }' . chr(10) . '    if (typeof o == "number" && Math.abs(o) < 0.0001 && o != 0) {' . chr(10) . '        return o.toExponential().replace(/e-(' . chr(92) . 'd)$/,"e-0$1");' . chr(10) . '    }' . chr(10) . '    if (typeof o === "boolean") {' . chr(10) . '        return o ? "1" : "";' . chr(10) . '    }' . chr(10) . '    if (typeof o !== "string") {' . chr(10) . '        return "" + o;' . chr(10) . '    }' . chr(10) . '    return o;' . chr(10) . '};' . chr(10) . chr(10) . 'p5num = function(o) {' . chr(10) . '    if (o == null) {' . chr(10) . '        return 0;' . chr(10) . '    }' . chr(10) . '    if (typeof o === "object" && (o instanceof Array)) {' . chr(10) . '        return o.length;' . chr(10) . '    }' . chr(10) . '    // if (typeof o.num === "function") {' . chr(10) . '    //     return o.num();' . chr(10) . '    // }' . chr(10) . '    if (typeof o !== "number") {' . chr(10) . '        return parseFloat(p5str(o));' . chr(10) . '    }' . chr(10) . '    return o;' . chr(10) . '};' . chr(10) . chr(10) . 'p5bool = function(o) {' . chr(10) . '    if (o) {' . chr(10) . '        if (typeof o === "boolean") {' . chr(10) . '            return o;' . chr(10) . '        }' . chr(10) . '        if (typeof o === "number") {' . chr(10) . '            return o;' . chr(10) . '        }' . chr(10) . '        if (typeof o === "string") {' . chr(10) . '            return o != "" && o != "0";' . chr(10) . '        }' . chr(10) . '        // if (typeof o.bool === "function") {' . chr(10) . '        //     return o.bool();' . chr(10) . '        // }' . chr(10) . '        if (typeof o.length === "number") {' . chr(10) . '            return o.length;' . chr(10) . '        }' . chr(10) . '        if (o instanceof Error) {' . chr(10) . '            return true;' . chr(10) . '        }' . chr(10) . '        for (var i in o) {' . chr(10) . '            return true;' . chr(10) . '        }' . chr(10) . '    }' . chr(10) . '    return false;' . chr(10) . '};' . chr(10) . chr(10) . 'p5and = function(a, fb) {' . chr(10) . '    if (p5bool(a)) {' . chr(10) . '        return fb();' . chr(10) . '    }' . chr(10) . '    return a;' . chr(10) . '};' . chr(10) . chr(10) . 'p5or = function(a, fb) {' . chr(10) . '    if (p5bool(a)) {' . chr(10) . '        return a;' . chr(10) . '    }' . chr(10) . '    return fb();' . chr(10) . '};' . chr(10) . chr(10) . 'p5defined_or = function(a, fb) {' . chr(10) . '    if (a == null) {' . chr(10) . '        return fb();' . chr(10) . '    }' . chr(10) . '    return a;' . chr(10) . '};' . chr(10) . chr(10) . 'p5cmp = function(a, b) {' . chr(10) . '    return a > b ? 1 : a < b ? -1 : 0 ' . chr(10) . '};' . chr(10) . chr(10) . 'p5str_replicate = function(o, n) {' . chr(10) . '    n = p5num(n);' . chr(10) . '    return n ? Array(n + 1).join(o) : "";' . chr(10) . '};' . chr(10) . chr(10) . 'p5for = function(namespace, func, args) {' . chr(10) . '    var v_old = namespace["v__"];' . chr(10) . '    for(var i = 0; i < args.length; i++) {' . chr(10) . '        namespace["v__"] = args[i];' . chr(10) . '        func()' . chr(10) . '    }' . chr(10) . '    namespace["v__"] = v_old;' . chr(10) . '};' . chr(10) . chr(10) . 'p5for_lex = function(func, args) {' . chr(10) . '    for(var i = 0; i < args.length; i++) {' . chr(10) . '        func(args[i])' . chr(10) . '    }' . chr(10) . '};' . chr(10) . chr(10) . 'p5map = function(namespace, func, args) {' . chr(10) . '    var v_old = namespace["v__"];' . chr(10) . '    var out = [];' . chr(10) . '    for(var i = 0; i < args.length; i++) {' . chr(10) . '        namespace["v__"] = args[i];' . chr(10) . '        var o = p5list_to_a(func(1));' . chr(10) . '        for(var j = 0; j < o.length; j++) {' . chr(10) . '            out.push(o[j]);' . chr(10) . '        }' . chr(10) . '    }' . chr(10) . '    namespace["v__"] = v_old;' . chr(10) . '    return out;' . chr(10) . '};' . chr(10) . chr(10) . 'p5grep = function(namespace, func, args) {' . chr(10) . '    var v_old = namespace["v__"];' . chr(10) . '    var out = [];' . chr(10) . '    for(var i = 0; i < args.length; i++) {' . chr(10) . '        namespace["v__"] = args[i];' . chr(10) . '        if (p5bool(func(0))) {' . chr(10) . '            out.push(args[i])' . chr(10) . '        }' . chr(10) . '    }' . chr(10) . '    namespace["v__"] = v_old;' . chr(10) . '    return out;' . chr(10) . '};' . chr(10) . chr(10) . 'p5sort = function(namespace, func, args) {' . chr(10) . '    var a_old = namespace["v_a"];' . chr(10) . '    var b_old = namespace["v_b"];' . chr(10) . '    var out = ' . chr(10) . '        func == null' . chr(10) . '        ? args.sort()' . chr(10) . '        : args.sort(' . chr(10) . '            function(a, b) {' . chr(10) . '                namespace["v_a"] = a;' . chr(10) . '                namespace["v_b"] = b;' . chr(10) . '                return func(0);' . chr(10) . '            }' . chr(10) . '        );' . chr(10) . '    namespace["v_a"] = a_old;' . chr(10) . '    namespace["v_b"] = b_old;' . chr(10) . '    return out;' . chr(10) . '};' . chr(10) . chr(10) . 'perl5_to_js = function( source, namespace, var_env_js ) {' . chr(10) . '    // CORE.say(["source: [" + source + "]"]);' . chr(10) . chr(10) . '    var strict_old = p5pkg["Perlito5"].v_STRICT;' . chr(10) . '    var var_env_js_old = p5pkg["Perlito5"].v_VAR;' . chr(10) . '    p5pkg["Perlito5"].v_VAR = var_env_js;' . chr(10) . chr(10) . '    var namespace_old = p5pkg["Perlito5"].v_PKG_NAME;' . chr(10) . '    p5pkg["Perlito5"].v_PKG_NAME = namespace;' . chr(10) . chr(10) . '    match = p5call(p5pkg["Perlito5::Grammar"], "exp_stmts", [source, 0]);' . chr(10) . chr(10) . '    if ( !match || match._hash_.to != source.length ) {' . chr(10) . '        CORE.die(["Syntax error in eval near pos ", match._hash_.to]);' . chr(10) . '    }' . chr(10) . chr(10) . '    ast = p5pkg.CORE.bless([' . chr(10) . '        new p5HashRef({' . chr(10) . '            block:  p5pkg.CORE.bless([' . chr(10) . '                        new p5HashRef({' . chr(10) . '                            stmts:   p5pkg["Perlito5::Match"].flat([match]),' . chr(10) . '                        }),' . chr(10) . '                        p5pkg["Perlito5::AST::Lit::Block"]' . chr(10) . '                    ]),' . chr(10) . '        }),' . chr(10) . '        p5pkg["Perlito5::AST::Do"]' . chr(10) . '    ]);' . chr(10) . chr(10) . '    // CORE.say(["ast: [" + ast + "]"]);' . chr(10) . '    js_code = p5call(ast, "emit_javascript", []);' . chr(10) . '    // CORE.say(["js-source: [" + js_code + "]"]);' . chr(10) . chr(10) . '    p5pkg["Perlito5"].v_PKG_NAME = namespace_old;' . chr(10) . '    p5pkg["Perlito5"].v_VAR      = var_env_js_old;' . chr(10) . '    p5pkg["Perlito5"].v_STRICT = strict_old;' . chr(10) . '    return js_code;' . chr(10) . '}' . chr(10) . chr(10))))
};
1;

1;
