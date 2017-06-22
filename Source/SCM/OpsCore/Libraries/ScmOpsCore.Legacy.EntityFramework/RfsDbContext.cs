using System.Data.Entity;
using BopsDataAccess;

namespace ScmOpsCore.Legacy.EntityFramework
{
    /// <summary>
    /// Entity Framework context for RFS data.
    /// </summary>
    public class RfsDbContext : DbContext
    {
        public RfsDbContext()
            : base("RfsDbContext")
        {
        }

        /// <summary>
        /// RFS billing statuses.
        /// </summary>
        public IDbSet<BopsRfsBillingStatus> BillingStatuses { get; set; }

        /// <inheritdoc/>
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            Database.SetInitializer(new NullDatabaseInitializer<RfsDbContext>());

            base.OnModelCreating(modelBuilder);
        }
    }
}
