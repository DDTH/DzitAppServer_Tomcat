<tr class="sectionTable sectionScripting">
    <td class="leftPanel resizable">

        <div class="accordion" id="memberCheckListAccordion">
            <h3><a href="#">Select Members</a></h3>

            <div id="memberCheckList">
            </div>
        </div>
        <div class="accordion" id="scriptLanguageAccordion">
            <h3><a href="#">Script Language</a></h3>

            <div>
                <div id="scriptRadioList">
                    <input type="radio" id="radiojavascript" name="radioscriptlanguage" checked="checked"
                           value="javascript"/><label for="radiojavascript" class="itemLink">Javascript</label>
                    <br/><input type="radio" id="radiogroovy" name="radioscriptlanguage" value="groovy"/><label
                        for="radiogroovy" class="itemLink">Groovy</label>
                    <br/><input type="radio" id="radiojruby" name="radioscriptlanguage" value="jruby"/><label
                        for="radiojruby" class="itemLink">JRuby</label>
                    <br/><input type="radio" id="radiobeanshell" name="radioscriptlanguage"
                                value="beanshell"/><label
                        for="radiobeanshell" class="itemLink">BeanShell</label>
                </div>
            </div>
        </div>

    </td>
    <td style="vertical-align: top; padding: 10px;">
        <b>Script:</b><br/>
        <textarea id="scriptarea" rows="10" cols="100" style="padding: 15px; ">
            function echo() {
            var name = hazelcast.getName();
            var node = hazelcast.getCluster().getLocalMember();
            return name + ' => ' + node;
            }
            echo();
        </textarea>
        <br/>
        <br/>
        <button class="button" style="margin-left: 50px;" onclick="sendScript()">Execute</button>
        <br/>
        <br/>

        <b>Result:</b><br/>
        <textarea id="scriptResult" rows="10" cols="100"
                  style="padding: 15px; border: 3px solid #e6e6fa; background-color: #000000; color: #ffffff; font-weight:bold; "></textarea>

    </td>
</tr>
