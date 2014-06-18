<%@page import="org.languagetool.*" %>
<%@page import="org.languagetool.tools.StringTools" %>
<%@page import="org.hibernate.*" %>

<html>
<head>
    <title><g:message code="ltc.wikicheck.title"/></title>
    <meta name="layout" content="main" />
</head>
<body>

<div class="body">

    <g:render template="/languageSelection"/>

    <div class="dialog">

        <h2 class="firstHeadline"><g:link controller="pageCheck" params="[lang: lang.getShortName()]"><g:message code="ltc.wiki.check"/></g:link></h2>

        <div class="mainPart">
            <p><g:message code="ltc.wiki.check.explain"/></p>
        </div>

        <h2><g:link controller="feedMatches" action="list" params="[lang: lang.getShortName()]"><g:message code="ltc.feed.matches.title"/></g:link></h2>

        <div class="mainPart">
            <p>
                <g:message code="ltc.feed.matches.explain.short"/>
                <g:message code="ltc.feed.matches.not.available"/>
            </p>
        </div>

    <!-- comment out, that DB table is currently empty
        <h2><g:link controller="corpusMatch" action="list" params="[lang: lang.getShortName()]"><g:message code="ltc.check.results"/></g:link></h2>

        <div class="mainPart">
            <p><g:message code="ltc.check.explain.short"/></p>
        </div> -->

    </div>

    <div style="margin-top: 30px">
        <g:render template="/languageToolVersion"/>
    </div>

</div>

</body>
</html>
