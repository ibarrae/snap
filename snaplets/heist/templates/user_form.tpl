<dfForm action="${action}">
  <dfChildErrorList />

  <dfLabel ref="name">Name: </dfLabel>
  <dfInputText ref="name" />
  <br>

  <dfLabel ref="email">E-mail: </dfLabel>
  <dfInputText ref="email" />
  <br>

  <dfLabel ref="birthday">Birthday: </dfLabel>
  <dfInputText ref="birthday" type="date" />
  <br>

  <dfSubView ref="pass_conf">
      <apply template="password_form" />
  </dfSubView>

  <dfLabel ref="gender">Gender: </dfLabel>
  <dfInputSelect ref="gender" />
  <br>

  <dfLabel ref="income">Income: </dfLabel>
  <dfInputText ref="income" type="number" />
  <br>

  <dfInputSubmit value="Save" />
</dfForm>