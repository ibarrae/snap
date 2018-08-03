<apply template="base">
  <h1>Edit User</h1>
  <br/>
  <bind tag="action"></bind>
  <bind tag="inputName">
    <dfInputText ref="name" value="${name}"/>
  </bind>
  <bind tag="inputEmail">
    <dfInputText ref="email" value="${email}"/>
  </bind>
  <bind tag="inputBirthday">
    <dfInputText ref="birthday" type="date" value="${birthday}" />
  </bind>
  <bind tag="inputGender">
    <dfInputSelect ref="gender" value="${gender}"/>
  </bind>
  <bind tag="inputIncome">
    <dfInputText ref="income" type="number" value="${income}"/>
  </bind>
  <bind tag="inputPassword">
    <dfInputPassword ref="password" value="${password}" />
  </bind>
  <apply template="user_form"/>
</apply>