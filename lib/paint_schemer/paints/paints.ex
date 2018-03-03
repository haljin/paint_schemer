defmodule PaintSchemer.Paints do
  @moduledoc """
  The Paints context.
  """

  import Ecto.Query, warn: false
  alias PaintSchemer.Repo

  alias PaintSchemer.Paints.Manufacturer

  @doc """
  Returns the list of paint_manufacturers.

  ## Examples

      iex> list_paint_manufacturers()
      [%Manufacturer{}, ...]

  """
  def list_paint_manufacturers do
    Repo.all(Manufacturer)
  end

  @doc """
  Gets a single manufacturer.

  Raises `Ecto.NoResultsError` if the Manufacturer does not exist.

  ## Examples

      iex> get_manufacturer!(123)
      %Manufacturer{}

      iex> get_manufacturer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_manufacturer!(id), do: Repo.get!(Manufacturer, id)

  @doc """
  Creates a manufacturer.

  ## Examples

      iex> create_manufacturer(%{field: value})
      {:ok, %Manufacturer{}}

      iex> create_manufacturer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_manufacturer(attrs \\ %{}) do
    %Manufacturer{}
    |> Manufacturer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manufacturer.

  ## Examples

      iex> update_manufacturer(manufacturer, %{field: new_value})
      {:ok, %Manufacturer{}}

      iex> update_manufacturer(manufacturer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_manufacturer(%Manufacturer{} = manufacturer, attrs) do
    manufacturer
    |> Manufacturer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manufacturer.

  ## Examples

      iex> delete_manufacturer(manufacturer)
      {:ok, %Manufacturer{}}

      iex> delete_manufacturer(manufacturer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_manufacturer(%Manufacturer{} = manufacturer) do
    Repo.delete(manufacturer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manufacturer changes.

  ## Examples

      iex> change_manufacturer(manufacturer)
      %Ecto.Changeset{source: %Manufacturer{}}

  """
  def change_manufacturer(%Manufacturer{} = manufacturer) do
    Manufacturer.changeset(manufacturer, %{})
  end


  alias PaintSchemer.Paints.PaintType

  @doc """
  Returns the list of paint_types.

  ## Examples

      iex> list_paint_types()
      [%PaintType{}, ...]

  """
  def list_paint_types do
    Repo.all(PaintType)
  end

  @doc """
  Gets a single paint_type.

  Raises `Ecto.NoResultsError` if the Paint type does not exist.

  ## Examples

      iex> get_paint_type!(123)
      %PaintType{}

      iex> get_paint_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_paint_type!(id), do: Repo.get!(PaintType, id)

  @doc """
  Creates a paint_type.

  ## Examples

      iex> create_paint_type(%{field: value})
      {:ok, %PaintType{}}

      iex> create_paint_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_paint_type(attrs \\ %{}) do
    %PaintType{}
    |> PaintType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a paint_type.

  ## Examples

      iex> update_paint_type(paint_type, %{field: new_value})
      {:ok, %PaintType{}}

      iex> update_paint_type(paint_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_paint_type(%PaintType{} = paint_type, attrs) do
    paint_type
    |> PaintType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PaintType.

  ## Examples

      iex> delete_paint_type(paint_type)
      {:ok, %PaintType{}}

      iex> delete_paint_type(paint_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_paint_type(%PaintType{} = paint_type) do
    Repo.delete(paint_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking paint_type changes.

  ## Examples

      iex> change_paint_type(paint_type)
      %Ecto.Changeset{source: %PaintType{}}

  """
  def change_paint_type(%PaintType{} = paint_type) do
    PaintType.changeset(paint_type, %{})
  end

  alias PaintSchemer.Paints.Paint

  @doc """
  Returns the list of paints.

  ## Examples

      iex> list_paints()
      [%Paint{}, ...]

  """
  def list_paints do
    Repo.all paint_associative_expr()
  end

  @doc """
  Gets a single paint.

  Raises `Ecto.NoResultsError` if the Paint does not exist.

  ## Examples

      iex> get_paint!(123)
      %Paint{}

      iex> get_paint!(456)
      ** (Ecto.NoResultsError)

  """
  def get_paint!(id), do:  Repo.get! paint_associative_expr(), id
  @doc """
  Creates a paint.

  ## Examples

      iex> create_paint(%{field: value})
      {:ok, %Paint{}}

      iex> create_paint(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_paint(attrs \\ %{}) do
    %Paint{}
    |> Paint.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a paint.

  ## Examples

      iex> update_paint(paint, %{field: new_value})
      {:ok, %Paint{}}

      iex> update_paint(paint, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_paint(%Paint{} = paint, attrs) do
    paint
    |> Paint.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Paint.

  ## Examples

      iex> delete_paint(paint)
      {:ok, %Paint{}}

      iex> delete_paint(paint)
      {:error, %Ecto.Changeset{}}

  """
  def delete_paint(%Paint{} = paint) do
    Repo.delete(paint)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking paint changes.

  ## Examples

      iex> change_paint(paint)
      %Ecto.Changeset{source: %Paint{}}

  """
  def change_paint(%Paint{} = paint) do
    Paint.changeset(paint, %{})
  end

  defp paint_associative_expr() do
    from p in Paint,
        join: t in assoc(p, :type),
        join: m in assoc(p, :manufacturer),
        preload: [type: t, manufacturer: m]
  end

end
