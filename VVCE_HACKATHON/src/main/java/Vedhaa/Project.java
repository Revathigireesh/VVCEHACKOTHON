package Vedhaa;

public class Project {
    private int projectID;
    private String title;
    private String description;
    private String accessLink;

    public Project(int projectID, String title, String description, String accessLink) {
        this.projectID = projectID;
        this.title = title;
        this.description = description;
        this.accessLink = accessLink;
    }

    public int getProjectID() {
        return projectID;
    }

    public void setProjectID(int projectID) {
        this.projectID = projectID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAccessLink() {
        return accessLink;
    }
}

