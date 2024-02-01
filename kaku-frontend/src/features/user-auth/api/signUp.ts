export const signUp = async (name: string, email: string, password: string) => {
  const response = await fetch(process.env.NEXT_PUBLIC_RAILS_API_URL + '/v1/auth', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      name: name,
      email: email,
      password: password
    })
  });

  if (response.ok) {
    return response;
  } else {
    throw new Error('Signup failed');
  }
};