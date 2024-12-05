package com.fpdisys.base.util;

import org.apache.catalina.connector.Request;
import org.apache.catalina.connector.Response;
import org.springframework.stereotype.Component;

import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
@Component
public class FpdisysErrorReport extends org.apache.catalina.valves.ErrorReportValve {
    @Override
    protected void report(Request request, Response response, Throwable throwable) {
        try {
            BufferedWriter out = new BufferedWriter(new OutputStreamWriter(response.getOutputStream(),"UTF-8"));
            out.write("<!DOCTYPE html>");
            out.write("<body>");
            out.write("aaaaaaaaaaaaaaaaaaaaaa");
            out.write("<script>alert('에러');history.back();</script>");
            out.write("bbbbbbbbbbbbbbbbbbbbbb");
            out.write("</body>");
            out.write("</html>");
            out.close();

        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
