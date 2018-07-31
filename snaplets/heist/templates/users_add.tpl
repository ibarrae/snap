<apply template="base">
  <h1>Add User</h1>
  <br/>
  <bind tag="action">/users/add</bind>
  <bind tag="inputName">
    <dfInputText ref="name"/>
  </bind>
  <bind tag="inputEmail">
    <dfInputText ref="email"/>
  </bind>
  <bind tag="inputBirthday">
    <dfInputText ref="birthday" type="date"/>
  </bind>
  <bind tag="inputGender"><dfInputSelect ref="gender"/></bind>
  <bind tag="inputIncome">
    <dfInputText ref="income" type="number"/>
  </bind>
  <bind tag="inputPassword">
    <dfInputPassword ref="password" />
  </bind>
  <apply template="user_form"/>
</apply>