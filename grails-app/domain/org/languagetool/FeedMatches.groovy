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

/**
 * An error detected by the Atom Feed checker.
 * To be populated from external software, not from Grails.
 * 
 * NOTE: table should use MYISAM engine, InnoDB is too slow 
 */
class FeedMatches {

    static mapping = {
        version(defaultValue: 1)  // as this field is filled from an external program
        languageCode(index: 'language_code_idx')
        ruleId(index: 'rule_id_idx')
        title(index: 'title_idx')
        fixDiffId(index: 'fix_diff_id_idx')
        ruleCategory(index: 'rule_category_idx')
        editDate(index: 'edit_date_idx')
        fixDate(index: 'fix_date_idx')
    }

    static constraints = {
        fixDate(nullable: true)
        fixDiffId(nullable: true)
        ruleSubId(nullable: true)
    }

    String languageCode
    String ruleId
    String ruleSubId
    String ruleDescription
    String ruleMessage
    String ruleCategory
    String errorContext
    Date editDate
    String title
    Date fixDate
    long diffId
    Long fixDiffId
    
}
