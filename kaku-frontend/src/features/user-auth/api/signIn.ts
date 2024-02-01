export const signIn = async (email: string, password: string) => {
  const response = await fetch(process.env.NEXT_PUBLIC_RAILS_API_URL + '/v1/auth/sign_in', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      email: email,
      password: password
    })
  });

  if (response.ok) {
    return response;
  } else {
    throw new Error('Signin failed');
  }
};