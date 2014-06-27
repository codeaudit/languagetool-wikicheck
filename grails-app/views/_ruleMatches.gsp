<%@page import="org.languagetool.tools.ContextTools; org.languagetool.rules.patterns.PatternRule; org.languagetool.Language" %>

<ul>
    <g:set var="maxMatches" value="${100}"/>
    <g:each in="${matches}" var="matchInfo" status="i">
        <g:if test="${i < maxMatches}">

            <li class="errorList">
                ${matchInfo.getMessage().replaceAll("<suggestion>", "<span class='correction'>").replaceAll("</suggestion>", "</span>")}

                <g:if test="${!hideRuleLink}">
                    <g:set var="langParam" value="${language?.getShortNameWithCountryAndVariant() ? language.getShortNameWithCountryAndVariant() : lang}"/>
                </g:if>

               <br/>
               <g:set var="css" value="${matchInfo.getRule().isDictionaryBasedSpellingRule() ? 'spellingError' : 'error'}"/>
                <%
                  ContextTools contextTools =  new ContextTools();
                  contextTools.setContextSize(100);
                  contextTools.setErrorMarkerStart("<span class='" + css + "'>");
                  contextTools.setErrorMarkerEnd("</span>");
                  contextTools.setEscapeHtml(true);
                %>
                <span class="exampleSentence">${contextTools.getContext(matchInfo.getFromPos(), matchInfo.getToPos(), textToCheck)}</span>
                <%
                  // this is used by the rule editor to set the 'marker' element in the wrong example sentences: 
                  contextTools.setContextSize(1000);
                  contextTools.setErrorMarkerStart("<marker>");
                  contextTools.setErrorMarkerEnd("</marker>");
                  contextTools.setEscapeHtml(true);
                %>
                <span class="internalMarkerInfo" style="display: none">${contextTools.getContext(matchInfo.getFromPos(), matchInfo.getToPos(), textToCheck).replace('&nbsp;', ' ')}</span>
                <br />
            </li>

        </g:if>
        <g:elseif test="${i == maxMatches}">
            <div class="warn">More than ${maxMatches} possible errors found, stopping</div>
        </g:elseif>
        <g:else>
            <%-- nothing --%>
        </g:else>
    </g:each>
    <g:if test="${matches != null && matches.size() == 0 && params.lang && params.lang != 'auto'}">
       <li><g:message code="ltc.no.rule.matches" args="${[Language.getLanguageForShortName(params.lang)]}"/></li>
    </g:if>
    <g:elseif test="${matches != null && matches.size() == 0 && params.language && params.language != 'auto'}">
       <li><g:message code="ltc.no.rule.matches" args="${[Language.getLanguageForShortName(params.language)]}"/></li>
    </g:elseif>
</ul>
