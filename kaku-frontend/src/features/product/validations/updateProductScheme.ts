import * as yup from 'yup';

export const updateProductScheme = yup.object().shape({
  name: yup
    .string()
    .required('名前は必須です')
    .min(1, '名前は少なくとも1文字以上でなければなりません')
    .max(15, '名前は最大15文字までです'),
  price: yup
    .number()
    .required('価格は必須です')
    .integer('価格は整数でなければなりません')
    .min(0, '価格は0以上でなければなりません'),
  stock: yup
    .number()
    .required('在庫数は必須です')
    .integer('在庫数は整数でなければなりません')
    .min(0, '在庫数は0以上でなければなりません'),
  description: yup
    .string()
    .required('説明文は必須です')
    .max(1000, '説明文は最大1000文字までです'),
  image_url: yup
    .string()
    .required('画像URLは必須です'),
});