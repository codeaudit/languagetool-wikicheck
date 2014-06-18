<p><g:message code="ltc.wikicheck.intro"/></p>

<div style="margin-top:10px;margin-bottom:10px;">
    <g:form action="pageCheck" method="get">
        <g:message code="ltc.wikicheck.url"/> <input autofocus style="width:350px" name="url" value="${url?.encodeAsHTML()}" placeholder="${message(code:'ltc.wikicheck.placeholder')}"/>
        <input type="hidden" name="lang" value="${langCode}"/>
        <input type="submit" value="${message(code:'ltc.wikicheck.check.page')}"/>
    </g:form>
</div>

<g:link action="index" params="${[url: message(code:'ltc.wikicheck.example.page.url'), lang: langCode]}"><g:message code="ltc.wikicheck.example.page"/></g:link>
&middot; <g:link action="index" params="${[url: 'random:' + langCode, lang: langCode]}"><g:message code="ltc.wikicheck.random.page"/></g:link>

<p style="margin-top: 10px">
    <g:message code="ltc.wikicheck.bookmarklet"/>
    <a href="javascript:(function(){%20window.open('http://community.languagetool.org/wikiCheck/pageCheck?url='+escape(location.href));%20})();"><g:message code="ltc.wikicheck.bookmarklet.link"/></a></p>
