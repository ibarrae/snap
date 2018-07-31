redirectToUserEdit = (id) => {
  const url = "/users/edit/"+id;
  window.location.replace(url);
}

updateUser = () => {
  const url = '/users/put'
  const reqBody = {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json; charset=utf-8'
    },
    body: JSON.stringify(genUserObject())
  };
  fetch(url, reqBody)
  .then(() => {
      console.log('Edit success.');
  })
  .catch(error => {
    console.log(error);
  });
}

const genUserObject = () => {
  const getValue = (key) => {
    return document.getElementById(key).value;
  }
  const key = getValue('key');
  const name = getValue('name');
  const email = getValue('email');
  const birthday = getValue('birthday');
  const password = getValue('password');
  const gender = getValue('gender');
  const income = getValue('income');
  return {
    'key': parseInt(key),
    'name': name,
    'email': email,
    'birthday': birthday,
    'password': password,
    'gender': gender,
    'income': Number(income)
  };
}