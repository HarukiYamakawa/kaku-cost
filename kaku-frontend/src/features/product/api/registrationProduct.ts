import { RegistrationFormData } from '../types/RegistrationFormData';
export const registrationProduct = async (product: RegistrationFormData) => {
  try {
    const response = await fetch(process.env.NEXT_PUBLIC_RAILS_API_URL +"/v1/products", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
          product: product
      }),
    });
    if (!response.ok) {
      throw new Error('サーバーエラーが発生しました');
    }
    return response;
  } catch (error) {
    console.error(error);
    throw error;
  }
}