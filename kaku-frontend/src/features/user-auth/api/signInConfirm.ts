export const signInConfirm = async () => {
  const response = await fetch(process.env.NEXT_PUBLIC_RAILS_API_URL + "/v1/auth/validate_token", {
    method: "GET",
    headers: {
        'access-token': localStorage.getItem('access-token') || '',
        'client': localStorage.getItem('client') || '',
        'uid': localStorage.getItem('uid') || '',
    }
    });

  if (response.ok) {
    return response;
  } else {
    throw new Error('Signout failed');
  }
};