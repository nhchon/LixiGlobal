package vn.chonsoft.lixi.repositories.search;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.LixiOrder;

public interface LixiOrderSearchRepository extends JpaRepository<LixiOrder, Long>,
        SearchableRepository<LixiOrder>
{
}

