package model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;

public class Point {

    private final int id;
    private final double x;
    private final double y;
    private final double r;
    private final boolean hit;
    private final String currentTime;
    private final double executionTimeMS;

    public Point(int id, double x, double y, double r) {
        this.id = id;
        this.x = x;
        this.y = y;
        this.r = r;

        long startTime = System.nanoTime();

        hit = calculate(x, y, r);

        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        currentTime = formatter.format(new Date());

        executionTimeMS = ((double) System.nanoTime() - startTime) / Math.pow(10, 6);
    }

    public int getId() {
        return id;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public boolean isHit() {
        return hit;
    }

    public String getCurrentTime() {
        return currentTime;
    }

    public double getExecutionTimeMS() {
        return executionTimeMS;
    }

    private boolean calculate(double x, double y, double r) {
        if (x <= 0 && y <= 0) {
            return (x >= -r && y >= -r / 2);
        }
        if (x <= 0 && y >= 0) {
            return (y <= 2 * x + r);
        }
        if (x >= 0 && y <= 0) {
            return (Math.pow(x, 2) + Math.pow(y, 2) <= Math.pow(r, 2));
        }
        return false;
    }

    public String toJSON() {
        return "{" +
                "\"id\":" + id +
                ", \"x\":" + x +
                ", \"y\":" + y +
                ", \"r\":" + r +
                ", \"hit\":" + hit +
                ", \"currentTime\":\"" + currentTime + '\"' +
                ", \"executionTimeMS\":" + executionTimeMS +
                '}';
    }

}