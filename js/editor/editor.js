define(['./codemirror','./consola'], function (CodeMirror, Consola) {
    'use strict';

    var sel_top = document.getElementById("buffers_top");
    var buffers = {};
    var ed_top = CodeMirror(document.getElementById("code_top"), { lineNumbers: true });

    function initialize(text){
        CodeMirror.on(sel_top, "change", function () {
            selectBuffer(ed_top, sel_top.options[sel_top.selectedIndex].value);
        });
        firstTab(text);
    }

    function openBuffer(name, text, mode) {
        buffers[name] = CodeMirror.Doc(text, mode);
        var opt = document.createElement("option");
        opt.appendChild(document.createTextNode(name));
        sel_top.appendChild(opt);
    }

    function newBuf(where) {
        var name = prompt("Nombre de la pestaña");
        if (name == null) return;
        if (buffers.hasOwnProperty(name)) {
            alert("Ya existe una pestaña con ese nombre");
            return;
        }
        openBuffer(name, "", "text/x-java");
        selectBuffer(where == "top" ? ed_top : ed_bot, name);
        var sel = where == "top" ? sel_top : sel_bot;
        sel.value = name;
    }

    function selectBuffer(editor, name) {
        var buf = buffers[name];
        if (buf.getEditor()) buf = buf.linkedDoc({ sharedHist: true });
        var old = editor.swapDoc(buf);
        var linked = old.iterLinkedDocs(function (doc) { linked = doc; });
        if (linked) {
            // Make sure the document in buffers is the one the other view is looking at
            for (var name in buffers) if (buffers[name] == old) buffers[name] = linked;
            old.unlinkDoc(linked);
        }
        Consola.clear();
        editor.focus();
    }

    function firstTab(text){
        openBuffer("pestaña1", text, "text/x-java");
        selectBuffer(ed_top, "pestaña1");
    }

    function getText(){
        return ed_top.getValue();
    }

    return {
        initialize : initialize,
        newBuf: newBuf,
        getText: getText
    };
});