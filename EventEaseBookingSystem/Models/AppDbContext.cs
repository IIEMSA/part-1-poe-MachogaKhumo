using Microsoft.EntityFrameworkCore;
using EventEaseBookingSystem.Models;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    public DbSet<Venue> Venue { get; set; }
    public DbSet<Event> Event { get; set; }
    public DbSet<Booking> Booking { get; set; }

  
}
