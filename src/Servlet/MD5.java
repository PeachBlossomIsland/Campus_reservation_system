package Servlet;

import java.security.MessageDigest;
import java.util.logging.Logger;

/**
 * MD5�����㷨
 */
public class MD5 {

    public static String MD5(String key) {
        char hexDigits[] = {
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
        };
        try {
            byte[] btInput = key.getBytes();
            // ���MD5ժҪ�㷨�� MessageDigest ����
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            // ʹ��ָ�����ֽڸ���ժҪ
            mdInst.update(btInput);
            // �������
            byte[] md = mdInst.digest();
            // ������ת����ʮ�����Ƶ��ַ�����ʽ
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        } catch (Exception e) {
            return null;
        }
    }

    public static String get_md5(String str,int n){
    	String res=str;
        for(int i=0;i<n;i++)
        {
        	res = MD5(res);
        	System.out.println(res);
        }
		return res;
    }
    public static void main(String[] args)
    {
    	String code=MD5.get_md5("seed",2);
    	System.out.println(code);
    }
}
