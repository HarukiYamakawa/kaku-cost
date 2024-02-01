import * as yup from 'yup';

export const signInFormSchema = yup.object().shape({
// emailは存在し、メールアドレスの形式に合致する
email: yup.string()
 .required('Emailは必須です')
 .email('Emailの形式が正しくありません'),

// passwordは存在し、最小8文字、最大20文字まで
password: yup.string()
 .required('Passwordは必須です')
 .min(8, 'Passwordは8文字以上で入力してください')
 .max(20, 'Passwordは20文字以内で入力してください'),

});