package model;


import java.io.Serializable;
import java.util.LinkedList;
import java.util.Objects;

public class PointsBean  {
    private final LinkedList<Point> points = new LinkedList<>();

    private int totalPoints = 0;

    public PointsBean(){}

    public void add(Point point) {
        this.points.add(point);
        totalPoints++;
    }

    public LinkedList<Point> getPoints() {
        return points;
    }

    public int getTotalPoints() {
        return totalPoints;
    }


}