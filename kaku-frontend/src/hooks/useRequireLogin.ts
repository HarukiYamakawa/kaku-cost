import { AuthContext } from '@/contexts/AuthContext';
import { useContext } from 'react';
import { useRouter } from 'next/navigation';

export const useRequireLogin = () => {
  const { isLogin } = useContext(AuthContext);
  const router = useRouter();

  if (!isLogin) {
    router.push('/login');
  }
}