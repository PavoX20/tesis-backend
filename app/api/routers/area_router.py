from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.models.area import Area
from app.crud.area_crud import (
    get_all_areas, get_area_by_id,
    create_area, update_area, delete_area
)

router = APIRouter(prefix="/areas", tags=["Areas"])

@router.get("/", response_model=list[Area])
def listar_areas(session: Session = Depends(get_session)):
    return get_all_areas(session)

@router.get("/{area_id}", response_model=Area)
def obtener_area(area_id: int, session: Session = Depends(get_session)):
    area = get_area_by_id(session, area_id)
    if not area:
        raise HTTPException(status_code=404, detail="Área no encontrada")
    return area

@router.post("/", response_model=Area, status_code=201)
def crear_area(data: Area, session: Session = Depends(get_session)):
    return create_area(session, data)

@router.put("/{area_id}", response_model=Area)
def actualizar_area(area_id: int, data: Area, session: Session = Depends(get_session)):
    updated = update_area(session, area_id, data)
    if not updated:
        raise HTTPException(status_code=404, detail="Área no encontrada")
    return updated

@router.delete("/{id_area}", status_code=204)
def eliminar_area(id_area: int, session: Session = Depends(get_session)):
    obj = session.get(Area, id_area)
    if not obj:
        raise HTTPException(404, "Area no encontrada")
    session.delete(obj)
    session.commit()
    return  # 204 No Content