package comDao;

import java.sql.ResultSet;
import java.sql.SQLException;

public class certificate {

    private String version;
    private String issuer;
    private String serial_Number;
    private String sign_Algorithm;
    private String digest_Algorithm;
    private String organization;
    private String start_time;
    private String end_time;
    private String file_path;

    public certificate(ResultSet resultSet) throws SQLException {
        while(resultSet.next()){
            this.version = resultSet.getString("version");
            this.issuer = resultSet.getString("issuer");
            this.serial_Number = resultSet.getString("serial_Number");
            this.sign_Algorithm = resultSet.getString("sign_Algorithm");
            this.digest_Algorithm = resultSet.getString("digest_Algorithm");
            this.organization = resultSet.getString("organization");
            this.start_time = resultSet.getString("start_time");
            this.end_time = resultSet.getString("end_time");
            this.file_path = resultSet.getString("file_path");
        }
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getIssuer() {
        return issuer;
    }

    public void setIssuer(String issuer) {
        this.issuer = issuer;
    }

    public String getSerial_Number() {
        return serial_Number;
    }

    public void setSerial_Number(String serial_Number) {
        this.serial_Number = serial_Number;
    }

    public String getSign_Algorithm() {
        return sign_Algorithm;
    }

    public void setSign_Algorithm(String sign_Algorithm) {
        this.sign_Algorithm = sign_Algorithm;
    }

    public String getDigest_Algorithm() {
        return digest_Algorithm;
    }

    public void setDigest_Algorithm(String digest_Algorithm) {
        this.digest_Algorithm = digest_Algorithm;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public String getFile_path() {
        return file_path;
    }

    public void setFile_path(String file_path) {
        this.file_path = file_path;
    }

}
