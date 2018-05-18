package Servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.util.List;
import java.util.concurrent.Executor;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.sun.net.httpserver.HttpContext;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
/*
 * 关于图片上传的实现有二个很好的网站：
 * http://xinklabi.iteye.com/blog/1831926
 * http://www.runoob.com/servlet/servlet-file-uploading.html
 * 可以好好看一下
 */
public class UploadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	//上传配置
	 private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
	 private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
	 private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
	 /**
   * 上传数据及保存文件
	  */
	    protected void doPost(HttpServletRequest request,
	        HttpServletResponse response) throws ServletException, IOException {
	    	request.setCharacterEncoding("utf-8");
	        response.setCharacterEncoding("utf-8");
	        String kind=request.getParameter("k");
	        String id=request.getParameter("id");
	        String UPLOAD_DIRECTORY=null;
	        System.out.println("UploadServlet:kind:"+kind+" id:"+id);
	        //上传文件目录设置：
	        if(kind.trim().equals("tea"))
	        {
	        	UPLOAD_DIRECTORY= "images/teacher_images";
	        }else{
	        	UPLOAD_DIRECTORY = "images/student_images";
	        }
	        // 检测是否为多媒体上传
	        if (!ServletFileUpload.isMultipartContent(request)) {
	            // 如果不是则停止
	            PrintWriter writer = response.getWriter();
	            writer.println("Error: 表单必须包含 enctype=multipart/form-data");
	            writer.flush();
	            return;
	        }
	        // 配置上传参数
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
	        factory.setSizeThreshold(MEMORY_THRESHOLD);
	        // 设置临时存储目录,这个目录是tomcat服务器下的一个tmp目录下，
	        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
	 
	        ServletFileUpload upload = new ServletFileUpload(factory);
	         
	        // 设置最大文件上传值
	        upload.setFileSizeMax(MAX_FILE_SIZE);
	         
	        // 设置最大请求值 (包含文件和表单数据)
	        upload.setSizeMax(MAX_REQUEST_SIZE);

	        // 中文处理
	        upload.setHeaderEncoding("UTF-8"); 

	        // 构造临时路径来存储上传的文件
	        // 这个路径相对当前应用的目录
	        String uploadPath = request.getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY;       
	        // 如果目录不存在则创建
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdir();
	        }
	 
	        try {
	            // 解析请求的内容提取文件数据
	            @SuppressWarnings("unchecked")
	            List<FileItem> formItems = upload.parseRequest(request);
	 
	            if (formItems != null && formItems.size() > 0) {
	                // 迭代表单数据
	                for (FileItem item : formItems) {
	                    // 处理不在表单中的字段
	                    if (!item.isFormField()) {
	                        String fileName = new File(item.getName()).getName();
	                        System.out.println(fileName);
	                        fileName=id+fileName.substring(fileName.lastIndexOf("."));
	                        String filePath = uploadPath + File.separator + fileName;
	                        File storeFile = new File(filePath);
	                        // 在控制台输出文件的上传路径
	                        System.out.println(filePath);
	                        // 保存文件到硬盘
	                        item.write(storeFile);
	                        request.setAttribute("message",
	                            "文件上传成功!");
	                    }
	                }
	            }
	        } catch (Exception ex) {
	            request.setAttribute("message",
	                    "错误信息: " + ex.getMessage());
	        }
        	response.getWriter().write("<script language='javascript'>alert('Upload picture success!');window.history.back(-1);</script>;");
	    }
	}
	 

