<dfForm action="${action}">
  <dfChildErrorList />

  <dfLabel ref="name">Name: </dfLabel>
  <inputName/>
  <br>

  <dfLabel ref="email">E-mail: </dfLabel>
  <inputEmail/>
  <br>

  <dfLabel ref="birthday">Birthday: </dfLabel>
  <inputBirthday/>
  <br>

  <dfSubView ref="pass_conf">
      <apply template="password_form" />
  </dfSubView>

  <dfLabel ref="gender">Gender: </dfLabel>
  <inputGender/>
  <br>

  <dfLabel ref="income">Income: </dfLabel>
  <inputIncome/>
  <br>

  <dfInputSubmit value="Save" />
</dfForm>