<dfForm action="${action}">
  <dfChildErrorList />

  <dfLabel ref="name">Name: </dfLabel>
  <dfInputText ref="name" />
  <br>

  <dfLabel ref="email">E-mail: </dfLabel>
  <dfInputText ref="email" />
  <br>

  <dfLabel ref="bd">Birthday: </dfLabel>
  <dfInputText ref="bd" />
  <br>

  <dfLabel ref="password">Password: </dfLabel>
  <dfInputPassword ref="password" />
  <br>

  <label for="user_form.passConf">Password confirmation: </label>
  <input type="password" id="user_form.passConf" name="user_form.passConf"/>
  <br>

  <dfLabel ref="gender">Gender: </dfLabel>
  <dfInputSelect ref="gender" />
  <br>

  <dfLabel ref="income">Income: </dfLabel>
  <dfInputText ref="income" />
  <br>

  <dfInputSubmit value="Save" />
</dfForm>