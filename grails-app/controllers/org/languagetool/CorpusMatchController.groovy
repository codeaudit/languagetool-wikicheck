/* LanguageTool Community 
 * Copyright (C) 2008 Daniel Naber (http://www.danielnaber.de)
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
 * USA
 */

package org.languagetool

class CorpusMatchController {

    def index = {
        redirect(action:list, params:params)
    }

    def list = {
        if(!params.max) params.max = 10
        if(!params.offset) params.offset = 0
        String langCode = "en"
        if (params.lang) {
            langCode = params.lang
        }
        // Grouped Overview of Rule Matches:
        def matchByRuleCriteria = CorpusMatch.createCriteria()
        def matchesByRule = matchByRuleCriteria {
            eq('languageCode', langCode)
            eq('isVisible', true)
            if (params.typeFilter) {
                eq('sourceType', params.typeFilter)
            }
            if (params.categoryFilter) {
                eq('ruleCategory', params.categoryFilter)
            }
            projections {
                groupProperty("ruleID")
                count "ruleID", 'mycount'
                property("ruleDescription")
            }
            order 'mycount', 'desc'
        }
        def matchByCategoryCriteria = CorpusMatch.createCriteria()
        def matchesByCategory = matchByCategoryCriteria {
            eq('languageCode', langCode)
            eq('isVisible', true)
            if (params.typeFilter) {
                eq('sourceType', params.typeFilter)
            }
            projections {
                groupProperty("ruleCategory")
                count "ruleCategory", 'mycount'
                property("ruleCategory")
            }
            order 'mycount', 'desc'
        }
        // Rule Matches for this language:
        List hiddenRuleIds = getHiddenRuleIds(langCode, grailsApplication.config.disabledRulesPropFile)
        def matchCriteria = CorpusMatch.createCriteria()
        def matches = matchCriteria {
            if (params.filter) {
                eq('ruleID', params.filter)
            } else {
                not {
                    inList('ruleID', hiddenRuleIds)
                }
            }
            if (params.typeFilter) {
                eq('sourceType', params.typeFilter)
            }
            if (params.categoryFilter) {
                eq('ruleCategory', params.categoryFilter)
            }
            eq('languageCode', langCode)
            eq('isVisible', true)
            firstResult(params.int('offset'))
            maxResults(params.int('max'))
        }
        def allMatchesCriteria = CorpusMatch.createCriteria()
        def allMatchesCount = allMatchesCriteria.count {
            if (params.filter) {
                eq('ruleID', params.filter)
            } else {
                not {
                    inList('ruleID', hiddenRuleIds)
                }
            }
            if (params.typeFilter) {
                eq('sourceType', params.typeFilter)
            }
            if (params.categoryFilter) {
                eq('ruleCategory', params.categoryFilter)
            }
            eq('languageCode', langCode)
            eq('isVisible', true)
        }
        def dateItem = CorpusMatch.findByLanguageCodeAndIsVisible(langCode, true)  // this assumes the date is the same everywhere...
        Language langObj = Language.getLanguageForShortName(langCode)
        [ corpusMatchList: matches,
                languages: SortedLanguages.get(), lang: langCode, totalMatches: allMatchesCount,
                matchesByRule: matchesByRule, matchesByCategory: matchesByCategory, hiddenRuleIds: hiddenRuleIds, language: langObj,
                date: dateItem ? dateItem.checkDate : null]
    }

    static List getHiddenRuleIds(String langCode, String propFileName) {
        List hiddenRuleIds = []
        Properties langToDisabledRules = new Properties()
        def fis = new FileInputStream(propFileName)
        try {
            langToDisabledRules.load(fis)
            hiddenRuleIds.addAll(langToDisabledRules.getProperty("all").split(",\\s*"))
            String langSpecificDisabledRulesStr = langToDisabledRules.get(langCode)
            if (langSpecificDisabledRulesStr) {
                List<String> langSpecificDisabledRules = langSpecificDisabledRulesStr.split(",")
                if (langSpecificDisabledRules) {
                    hiddenRuleIds.addAll(langSpecificDisabledRules)
                }
            }
        } finally {
            fis.close()
        }
        return hiddenRuleIds
    }

}