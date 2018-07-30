<apply template="base">
  <script src="/static/api.js"/>
  <h1> Users </h1>
  <br/>
  <a href ="/users/add">New User</a>
  <br/>
  <table>
    <thead>
      <th>Name</th>
      <th>Email</th>
      <th>Birthday</th>
      <th>Income</th>
      <th/>
    <thead>
    <tbody>
      <users>
        <tr>
          <td><name/></td>
          <td><mail/></td>
          <td><bd/></td>
          <td><income/></td>
          <td>
            <button onclick="deleteUser(${id})">Delete</button>
            <button>Update</button>
          </td>
        </tr>
      </users>
    </tbody>
  </table>
</apply>