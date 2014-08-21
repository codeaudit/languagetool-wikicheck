<!DOCTYPE html>
<html>
<head>
    <title><g:layoutTitle default="LanguageTool WikiCheck" /></title>
    <g:render template="/layouts/css"/>
    <link type="text/css" rel="stylesheet" href="${resource(dir:'css',file:'mobile.css')}" />
    <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <g:layoutHead />
    <r:layoutResources/>
</head>
<body>

<g:render template="/layouts/header"/>

<div id="spinner" class="spinner" style="display:none;">
    <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
</div>

<noscript class="warn">Please turn on JavaScript for full use of this site.</noscript>

<div id="mainContent">
    <g:layoutBody />
</div>

</body>
</html>
