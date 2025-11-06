from sqlmodel import Session, select
from app.models.area import Area

def get_all_areas(session: Session):
    return session.exec(select(Area)).all()

def get_area_by_id(session: Session, area_id: int):
    return session.get(Area, area_id)

def create_area(session: Session, data: Area):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

def update_area(session: Session, area_id: int, data: Area):
    area = session.get(Area, area_id)
    if not area:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(area, key, value)
    session.add(area)
    session.commit()
    session.refresh(area)
    return area

def delete_area(session: Session, area_id: int):
    area = session.get(Area, area_id)
    if not area:
        return None
    session.delete(area)
    session.commit()
    return area