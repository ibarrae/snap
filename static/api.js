const deleteUser = (id) => {
  const url = '/users/delete/'+id;
  const reqBody = {
    method: "DELETE"
  };
  fetch(url, reqBody)
  .then((data) => {
    alert('Correctly deleted');
  })
  .catch((error) => {
    alert('Something went wrong');
    console.log(error);
  })
}