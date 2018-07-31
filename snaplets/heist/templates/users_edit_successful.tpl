<apply template="base">
  <script src="/static/api.js"/>
  <script type="text/javascript">
    setTimeout(() => {
      updateUser();
    }, 500);
  </script>
  User edit was successful.
  <input type="hidden" id="key" value="${key}"/>
  <input type="hidden" id="name" value="${name}"/>
  <input type="hidden" id="email" value="${email}"/>
  <input type="hidden" id="birthday" value="${birthday}"/>
  <input type="hidden" id="password" value="${password}"/>
  <input type="hidden" id="gender" value="${gender}"/>
  <input type="hidden" id="income" value="${income}"/>
  <a href ="/users">Back</a>
</apply>